
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Cocoa
import FinderSync

class FinderSyncExt: FIFinderSync {

    static let EVENT_NAME_FOR_FINDER_CONTEXT_MENU = "RwxEditorFinderContextMenu"
    static let MENU_ITEM_TAG_RWX_EDITOR = 0
    static let URL_PREFIX = "file://"

    override init() {
        super.init()
        FIFinderSyncController.default().directoryURLs = [
            URL(fileURLWithPath: "/")
        ]
    }

    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        let menu = NSMenu(title: "Rwx Editor Menu")
        switch menuKind {
            case .contextualMenuForItems, .contextualMenuForContainer:
                let menuItem = NSMenuItem()
                    menuItem.title = String(NSLocalizedString("Rwx Editor", comment: ""))
                    menuItem.image = NSImage(systemSymbolName: "folder.badge.person.crop", accessibilityDescription: "")!
                    menuItem.action = #selector(onContextMenu(_:))
                    menuItem.tag = Self.MENU_ITEM_TAG_RWX_EDITOR
                    menuItem.target = self
                menu.addItem(menuItem)
            default: break
        }
        return menu
    }

    @objc func onContextMenu(_ menuItem: NSMenuItem) {
        if (menuItem.tag == Self.MENU_ITEM_TAG_RWX_EDITOR) {
            let items = FIFinderSyncController.default().selectedItemURLs()
            var pathWithNameCollection: [String] = []
            items?.forEach { url in
                let absolute = url.absoluteString
                if (absolute.isEmpty == false) {
                    pathWithNameCollection.append(
                        absolute.hasPrefix(Self.URL_PREFIX) ? String(absolute.dropFirst(Self.URL_PREFIX.count)) : absolute
                    )
                }
            }
            if (pathWithNameCollection.isEmpty == false) {
                if let object = FinderEvent(items: pathWithNameCollection).encode() {
                    DistributedNotificationCenter.default().postNotificationName(
                        Notification.Name(FinderSyncExt.EVENT_NAME_FOR_FINDER_CONTEXT_MENU),
                        object: object,
                        deliverImmediately: true
                    )
                }
            }
        }
    }

}
