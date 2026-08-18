
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

@main final class ThisApp: NSApplicationMultiLaunch, NSWindowDelegate {

    static let NOT_APPLICABLE = "—"
    static let WINDOW_MAIN_ID = "main"
    static let WINDOW_MAIN_TITLE_LOCALIZED = NSLocalizedString("RWX Editor | Settings", comment: "")
    static let WINDOW_POPUP_ID_PREFIX = "popup:"
    static let WINDOW_POPUP_TITLE_LOCALIZED = NSLocalizedString("RWX Editor", comment: "")

    @MainActor static public var appDelegate: ThisApp!

    static func main() {
        let app = NSApplication.shared
        Self.appDelegate = Self()
        app.delegate = Self.appDelegate
        app.run()
    }

    func applicationSupportsSecureRestorableState       (_    app: NSApplication) -> Bool { true }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }

    override func onLaunchViaClickIcon() {
        self.showWindowMain()
    }

    override func onLaunchViaReceivedURLs(urls: [URL]) {
        for url in urls {
            self.showWindowPopup(url)
        }
    }

    func showWindowMain() {
        Logger.customLog("Window \"Main\" will show")
        if let windowMain = NSWindow.customWindows[Self.WINDOW_MAIN_ID] {
            windowMain.show()
        } else {
            _ = NSWindow.makeNewOrShowExisting(
                ID   : Self.WINDOW_MAIN_ID,
                title: Self.WINDOW_MAIN_TITLE_LOCALIZED,
                size: CGSize(width: 700, height: 500),
                delegate: self,
                view: MainScene()
            )
        }
        if (!NSApplication.isXCodePreview) {
            NSApplication.showAppsDock()
            NSApp.mainMenu = NSMenu.main
            NSApplication.show() /* menu reactivation */
        }
    }

    func showWindowPopup(_ url: URL) {
        let ID = "\(Self.WINDOW_POPUP_ID_PREFIX)\(url.path)"
        Logger.customLog("Window \"Popup\" will show | ID: \(ID)")
        if let windowPopup = NSWindow.customWindows[ID] {
            windowPopup.show()
        } else {
            _ = NSWindow.makeNewOrShowExisting(
                ID: ID,
                title: Self.WINDOW_POPUP_TITLE_LOCALIZED,
                styleMask: [.titled, .closable],
                size: CGSize(width: MainScene.FRAME_WIDTH, height: 600),
                delegate: self,
                view: Popup(ID, url)
            )
        }
    }

    func windowWillClose(_ notification: Notification) {
        if let window = notification.object as? NSWindow, let ID = window.ID {
            switch ID {
                case Self.WINDOW_MAIN_ID:
                    Logger.customLog("Window \"Main\" will hide")
                    NSApplication.hideAppsDock()
                    NSApp.mainMenu = nil
                    /* bring the popup window to the foreground */
                    if (!NSWindow.customWindows.isEmpty) {
                        NSApplication.show()
                    }
                default:
                    if ID.hasPrefix(Self.WINDOW_POPUP_ID_PREFIX) {
                        Logger.customLog("Window \"Popup\" will hide | ID: \(ID)")
                        window.contentView = nil
                        window.delegate = nil
                        NSWindow.customWindows[ID] = nil
                    }
            }
        }
    }

}
