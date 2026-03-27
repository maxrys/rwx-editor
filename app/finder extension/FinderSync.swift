
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Cocoa
import FinderSync

let FINDER_EXT_MENU_TITLE = "RWX Editor Menu"
let FINDER_EXT_MENU_ITEMS = [
    (
        eventName: "RWXEditorFinderContextMenu",
        titleLocalized: NSLocalizedString("RWX Editor", comment: ""),
        iconName: "ContextMenuIcon"
    )
]

final class FinderSync: FIFinderSync {

    var selectedURLs: [URL] {
        if let urls = FIFinderSyncController.default().selectedItemURLs() {
            return urls
        }
        return []
    }

    override init() {
        super.init()
        self.updateWatchedVolumes()
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(self.updateWatchedVolumes), name: NSWorkspace.didMountNotification  , object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(self.updateWatchedVolumes), name: NSWorkspace.didUnmountNotification, object: nil)
        Logger.customLog("FinderSync Extension launched from: \(Bundle.main.bundlePath)")
    }

    @objc func updateWatchedVolumes() {
        var urls = Set<URL>()
        urls.insert(URL(fileURLWithPath: "/"))
        if let volumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) {
            for volume in volumes {
                urls.insert(volume)
            }
        }
        FIFinderSyncController.default().directoryURLs = urls
        Logger.customLog("FinderSync Extension Update volumes: \(urls.map { $0.path })")
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
                        menuItem.image = NSImage(named: item.iconName)!
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
                    if let resultURL = URL(string: URL.PREFIX_THIS_APP + url.absoluteString.trimPrefix(URL.PREFIX_FILE)) {
                        NSWorkspace.shared.open(
                            resultURL
                        )
                    }
                }
            }
        }
    }

}
