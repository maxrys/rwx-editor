
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

extension NSApplication {

    static public var appVersion      : String? { Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String }
    static public var appBuild        : String? { Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion"           ) as? String }
    static public var appCopyright    : String? { Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright"  ) as? String }
    static public var appNameLocalized: String  { Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName"       ) as? String ?? NSLocalizedString(ProcessInfo.processInfo.processName, comment: "") }

    static var isXCodePreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }

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
