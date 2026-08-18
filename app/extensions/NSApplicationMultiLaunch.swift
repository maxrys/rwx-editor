
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import AppKit

class NSApplicationMultiLaunch: NSObject, NSApplicationDelegate {

    enum LaunchType {
        case none
        case icon
        case urls([URL])
    }

    private var launchType: LaunchType = .none

    private func showLaunchType() {
        switch self.launchType {
            case .none          : Logger.customLog("LaunchType: none")
            case .icon          : Logger.customLog("LaunchType: icon")
            case .urls(let urls): Logger.customLog("LaunchType: urls | URLs: \(urls)")
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if case .none = self.launchType { self.launchType = .icon }
        if case .urls = self.launchType { self.launchType = .icon; return }
        self.showLaunchType()
        self.onLaunchViaClickIcon()
        if (!NSApplication.isXCodePreview) {
            NSApplication.show() /* bring the window to the foreground */
        }
    }

    func application(_ sender: NSApplication, open urls: [URL]) {
        if case .none = self.launchType { self.launchType = .urls(urls) }
        self.showLaunchType()
        self.onLaunchViaReceivedURLs(urls: urls)
        if (!NSApplication.isXCodePreview) {
            NSApplication.show() /* bring the window to the foreground */
        }
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
