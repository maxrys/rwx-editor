
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import AppKit

class NSApplicationMultiLaunch: NSObject, NSApplicationDelegate {

    enum LaunchType {
        case none
        case icon
        case urls
    }

    private var launchType: LaunchType = .none

    private func showLaunchType() {
        switch self.launchType {
            case .none: Logger.customLog("LaunchType: none")
            case .icon: Logger.customLog("LaunchType: icon")
            case .urls: Logger.customLog("LaunchType: urls")
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if (self.launchType == .none) { self.launchType = .icon }
        if (self.launchType == .urls) { self.launchType = .icon; return }
        self.showLaunchType()
        self.onLaunchViaClickIcon()
        NSApplication.show() /* bring the window to the foreground */
    }

    func application(_ sender: NSApplication, open urls: [URL]) {
        if (self.launchType == .none) { self.launchType = .urls }
        self.showLaunchType()
        self.onLaunchViaReceivedURLs(urls: urls)
        NSApplication.show() /* bring the window to the foreground */
    }

    func applicationShouldHandleReopen(_ app: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        self.showLaunchType()
        self.onLaunchViaClickIcon()
        return true
    }

    func onLaunchViaClickIcon() {
        fatalError("Subclasses must override onLaunchViaClickIcon()")
    }

    func onLaunchViaReceivedURLs(urls: [URL]) {
        fatalError("Subclasses must override onLaunchViaReceivedURLs()")
    }

}
