
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

final class ThisAppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {

    enum LaunchType {
        case pure
        case withURL
    }

    override init() {
        super.init()
    }

    private var launchType: LaunchType?

    func logLaunchType() {
        switch self.launchType {
            case .pure   : Logger.customLog("launchType = pure")
            case .withURL: Logger.customLog("launchType = withURL")
            case .none   : Logger.customLog("launchType = nil")
        }
    }

    func applicationSupportsSecureRestorableState       (_    app: NSApplication) -> Bool { true }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }

    func application(_ sender: NSApplication, open urls: [URL]) {
        self.logLaunchType()
        switch self.launchType {
            case .none: self.launchType = .withURL
            default   : break
        }
        for url in urls {
            self.showWindowPopup(
                fullpath: url.absoluteString.trimPrefix(URL_PREFIX_THIS_APP)
            )
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.logLaunchType()
        switch self.launchType {
            case .withURL: self.launchType = .pure
            case .none   : self.launchType = .pure; fallthrough
            case .pure   : self.showWindowMain()
        }
    }

    func applicationShouldHandleReopen(_ app: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        self.logLaunchType()
        switch self.launchType {
            case .withURL: self.launchType = .pure
            case .none   : self.launchType = .pure; fallthrough
            case .pure   : self.showWindowMain()
        }
        return true
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
        self.showMainMenu()
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

    func showMainMenu() {
        let appName = ProcessInfo.processInfo.processName
        let mainMenu = NSMenu(title: "MainMenu")

        /* MARK: App menu (About, Quit) */
        let appMenu = NSMenu()
            appMenu.addItem(withTitle: "About \(appName)", action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)), keyEquivalent: "")
            appMenu.addItem(NSMenuItem.separator())
            appMenu.addItem(withTitle: "Quit \(appName)", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        let appMenuItem = NSMenuItem()
            appMenuItem.submenu = appMenu
        mainMenu.addItem(appMenuItem)

        NSApp.mainMenu = mainMenu
    }

}
