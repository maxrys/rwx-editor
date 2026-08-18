
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import AppKit

extension NSMenu {

    static public var main: Self {

        let result = Self(
            title: "Main Menu"
        )

        /* MARK: App menu (About, Quit) */

        let appMenu = Self()

        appMenu.addItem(
            withTitle: String(format: NSLocalizedString("About %@" , comment: ""), NSApplication.appNameLocalized),
            action: #selector(NSApplication.orderFrontStandardAboutPanel(_:)),
            keyEquivalent: ""
        )

        appMenu.addItem(
            NSMenuItem.separator()
        )

        appMenu.addItem(
            withTitle: String(format: NSLocalizedString("Quit %@" , comment: ""), NSApplication.appNameLocalized),
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )

        let appMenuItem = NSMenuItem()
            appMenuItem.submenu = appMenu
        result.addItem(appMenuItem)

        return result
    }

}
