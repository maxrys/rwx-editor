
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

extension NSApplication {

    static func show() { NSApp.activate(ignoringOtherApps: true) }
    static func showAppsDock() { Self.shared.setActivationPolicy(.regular  ) }
    static func hideAppsDock() { Self.shared.setActivationPolicy(.accessory) }

    static func open(_ appURL: URL) {
        NSWorkspace.shared.openApplication(at: appURL, configuration: NSWorkspace.OpenConfiguration()) { (app, error) in
            if let error = error {
                Logger.customLog("Error: \(error.localizedDescription)")
            }
        }
    }

}
