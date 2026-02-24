
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    var selectedURLs: [URL] {
        if let urls = FIFinderSyncController.default().selectedItemURLs() {
            return urls
        }
        return []
    }

    override init() {
        super.init()
        FIFinderSyncController.default().directoryURLs = FINDER_EXT_DIRECTORY_URLS
        Logger.customLog("FinderSync Extension launched from: \(Bundle.main.bundlePath)")
    }

    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let selectedURLs = self.selectedURLs
        guard !selectedURLs.isEmpty else {
            return NSMenu()
        }
        let menu = NSMenu(title: FINDER_EXT_MENU_TITLE)
        switch menuKind {
            case .contextualMenuForItems, .contextualMenuForContainer:
                for (index, item) in FINDER_EXT_MENU_ITEMS.enumerated() {
                    let menuItem = NSMenuItem()
                        menuItem.title = item.titleLocalized
                        menuItem.image = NSImage(systemSymbolName: item.iconName, accessibilityDescription: "")!
                        menuItem.action = #selector(onContextMenu(_:))
                        menuItem.tag = index
                        menuItem.target = self
                    menu.addItem(menuItem)
                }
            default: break
        }
        return menu
    }

    @objc func onContextMenu(_ menuItem: NSMenuItem) {
        for (index, _) in FINDER_EXT_MENU_ITEMS.enumerated() {
            if (menuItem.tag == index) {
                for url in self.selectedURLs {
                    if let resultURL = URL(string: URL_PREFIX_THIS_APP + url.absoluteString.trimPrefix(URL_PREFIX_FILE)) {
                        NSWorkspace.shared.open(
                            resultURL
                        )
                    }
                }
            }
        }
    }

}
