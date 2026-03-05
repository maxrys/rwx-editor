
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Foundation

extension Process {

    enum ShellResult {
        case ok(data: [String])
        case error(code: Int32, text: String)
        case fatal
    }

    static func shell(path: String = "/bin/zsh", args: [String] = [], separatedBy: String = "\n") -> ShellResult {
        let task = Process()
        let pipeOut = Pipe()
        let pipeErr = Pipe()
        task.standardInput = nil
        task.standardOutput = pipeOut
        task.standardError = pipeErr
        task.executableURL = URL(fileURLWithPath: path)
        task.arguments = args
        do {
            try task.run()
            task.waitUntilExit()
            let stdOutResult = String(data: pipeOut.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
            let stdErrResult = String(data: pipeErr.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
            if (task.terminationStatus == 0) {
                return .ok(data:
                    stdOutResult
                        .trimPrefix("\n")
                        .trimSuffix("\n")
                        .components(separatedBy: separatedBy)
                )
            } else {
                return .error(
                    code: task.terminationStatus,
                    text: stdErrResult
                        .trimPrefix("\n")
                        .trimSuffix("\n")
                )
            }
        } catch {
            return .fatal
        }
    }

    static func systemUsers() -> [String] {
        let shellResult = Process.shell(
            path: "/usr/bin/env",
            args: ["dscl", ".", "list", "/Users"]
        )
        switch shellResult {
            case .ok(let data):
                Logger.customLog("systemUsers shellResult = ok")
                return data
            case .error(let code, let text):
                Logger.customLog("systemUsers shellResult = error | code = \(code) | text = \(text)")
                return []
            case .fatal:
                Logger.customLog("systemUsers shellResult = fatal")
                return []
        }
    }

    static func systemGroups() -> [String] {
        let shellResult = Process.shell(
            path: "/usr/bin/env",
            args: ["groups"],
            separatedBy: " "
        )
        switch shellResult {
            case .ok(let data):
                Logger.customLog("systemUsers shellResult = ok")
                return data
            case .error(let code, let text):
                Logger.customLog("systemUsers shellResult = error | code = \(code) | text = \(text)")
                return []
            case .fatal:
                Logger.customLog("systemUsers shellResult = fatal")
                return []
        }
    }

}
