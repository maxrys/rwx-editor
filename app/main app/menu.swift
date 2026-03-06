
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import AppKit

final class Menu {

    static func getMain() -> NSMenu {

        let appLocalizedName = Bundle.main.object(
            forInfoDictionaryKey: "CFBundleDisplayName"
        ) as? String ?? NSLocalizedString(
            ProcessInfo.processInfo.processName, comment: ""
        )

        let mainMenu = NSMenu(
            title: "Main Menu"
        )

        /* MARK: App menu (About, Quit) */

        let appMenu = NSMenu()

        appMenu.addItem(
            withTitle: String(format: NSLocalizedString("About %@" , comment: ""), appLocalizedName),
            action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)),
            keyEquivalent: ""
        )

        appMenu.addItem(
            NSMenuItem.separator()
        )

        appMenu.addItem(
            withTitle: String(format: NSLocalizedString("Quit %@" , comment: ""), appLocalizedName),
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )

        let appMenuItem = NSMenuItem()
            appMenuItem.submenu = appMenu
        mainMenu.addItem(appMenuItem)

        return mainMenu
    }

}
