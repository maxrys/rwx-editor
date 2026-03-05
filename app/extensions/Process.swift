
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension Process {

    enum ShellResult {
        case ok(data: [String])
        case error(code: Int32, text: String)
        case fatal
    }

    static func shell(path: String = "/bin/zsh", args: [String] = []) -> ShellResult {
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
                        .components(separatedBy: "\n")
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

}
