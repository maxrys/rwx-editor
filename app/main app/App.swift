
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

@main final class App: NSApplicationMultiLaunch, NSWindowDelegate {

    @MainActor private static var appDelegate: App!

    static func main() {
        let app = NSApplication.shared
        Self.appDelegate = App()
        app.delegate = Self.appDelegate
        app.run()
    }

    static var appVersion      : String? { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String }
    static var appBundleVersion: String? { Bundle.main.infoDictionary?["CFBundleVersion"           ] as? String }
    static var appCopyright    : String? { Bundle.main.infoDictionary?["NSHumanReadableCopyright"  ] as? String }

    func applicationSupportsSecureRestorableState       (_    app: NSApplication) -> Bool { true }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }

    override func onLaunchViaClickIcon() {
        self.showWindowMain()
    }

    override func onLaunchViaReceivedURLs(urls: [URL]) {
        for url in urls {
            self.showWindowPopup(
                fullpath: url.normalized(
                    isTrimDirSuffix: false
                )
            )
        }
    }

    func windowWillClose(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            if let ID = window.ID {
                if (ID == WINDOW_MAIN_ID) {
                    Logger.customLog("Main Window will hide")
                    NSApplication.hideAppsDock()
                }
                if (ID != WINDOW_MAIN_ID) {
                    Logger.customLog("Popup Window will hide | ID = \(ID)")
                    window.contentView = nil
                    window.delegate = nil
                    NSWindow.customWindows[ID] = nil
                }
            }
        }
    }

    func showWindowMain() {
        Logger.customLog("Main Window will show")
        if let windowMain = NSWindow.customWindows[WINDOW_MAIN_ID] {
            windowMain.show()
        } else {
            _ = NSWindow.makeAndShowFromSwiftUIView(
                ID   : WINDOW_MAIN_ID,
                title: WINDOW_MAIN_TITLE,
                isVisible: true,
                delegate: self,
                view: MainScene()
            )
        }
        NSApp.mainMenu = NSMenu.main
        NSApplication.showAppsDock()
    }

    func showWindowPopup(fullpath: String) {
        Logger.customLog("Popup Window will show | ID = \(fullpath)")
        if let windowPopup = NSWindow.customWindows[fullpath] {
            windowPopup.show()
        } else {
            _ = NSWindow.makeAndShowFromSwiftUIView(
                ID: fullpath,
                title: WINDOW_POPUP_TITLE,
                styleMask: [.titled, .closable],
                isVisible: true,
                delegate: self,
                view: Popup(
                    fullpath: fullpath
                )
            )
        }
    }

}
