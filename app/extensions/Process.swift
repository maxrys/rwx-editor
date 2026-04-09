
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Foundation

extension Process {

    static public var currentUserName: String? {
        ProcessInfo.processInfo.environment["USER"] ?? ""
    }

}
