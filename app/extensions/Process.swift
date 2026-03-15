
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Foundation

extension Process {

    enum ShellResult {
        case ok(lines: [String])
        case error(code: Int32, description: String)
        case fatal
    }

    static func shell(path: String = "/bin/zsh", args: [String] = [], separatedBy: String = "\n") -> ShellResult {
        let task = Self()
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
            if (task.terminationStatus == 0) {
                return .ok(
                    lines: pipeOut.fileHandleForReading.readDataToEndOfFile().toString
                        .trimPrefix("\n")
                        .trimSuffix("\n")
                        .components(separatedBy: separatedBy)
                )
            } else {
                return .error(
                    code: task.terminationStatus,
                    description: pipeErr.fileHandleForReading.readDataToEndOfFile().toString
                        .trimPrefix("\n")
                        .trimSuffix("\n")
                )
            }
        } catch {
            return .fatal
        }
    }

    static func systemUsers() -> [String] {
        let shellResult = Self.shell(
            path: "/usr/bin/env",
            args: ["dscl", ".", "list", "/Users"]
        )
        switch shellResult {
            case .ok(let lines):
                Logger.customLog("systemUsers shellResult = ok")
                return lines
            case .error(let code, let description):
                Logger.customLog("systemUsers shellResult = error | code = \(code) | description = \(description)")
                return []
            case .fatal:
                Logger.customLog("systemUsers shellResult = fatal")
                return []
        }
    }

    static func systemGroups() -> [String] {
        let shellResult = Self.shell(
            path: "/usr/bin/env",
            args: ["groups"],
            separatedBy: " "
        )
        switch shellResult {
            case .ok(let lines):
                Logger.customLog("systemGroups shellResult = ok")
                return lines
            case .error(let code, let description):
                Logger.customLog("systemGroups shellResult = error | code = \(code) | description = \(description)")
                return []
            case .fatal:
                Logger.customLog("systemGroups shellResult = fatal")
                return []
        }
    }

}
