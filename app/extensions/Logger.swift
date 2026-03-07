
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Foundation

extension Logger {

    static let logPathname: String = {
        /* open ~/Library/Containers/maxrys.RWX-Editor/Data/custom.log */
        FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("custom.log").path
    }()

    static func customLog(_ message: String) {
        #if DEBUG
            NSLog(message)
        #endif
    }

    static func customLogToFile(_ message: String) {
        #if DEBUG
            let escaped = message.replacingOccurrences(of: "'", with: "\"")
            _ = Process.shell(
                path: "/bin/zsh",
                args: ["-c", "echo '\(escaped)' >> '\(Self.logPathname)'"]
            )
        #endif
    }

}
