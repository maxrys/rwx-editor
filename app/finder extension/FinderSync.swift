
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Cocoa
import FinderSync

final class FinderSync: FIFinderSync {

    static let MENU_TITLE_LOCALIZED = NSLocalizedString("RWX Editor Menu", comment: "")

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
        let menu = NSMenu(title: Self.MENU_TITLE_LOCALIZED)
        if (menuKind == .contextualMenuForItems || menuKind == .contextualMenuForContainer) {
            let menuItem = NSMenuItem()
                menuItem.title = NSLocalizedString("RWX Editor", comment: "")
                menuItem.image = NSImage(named: "ContextMenuIcon")!
                menuItem.action = #selector(onContextMenu(_:))
                menuItem.tag = 0
                menuItem.target = self
            menu.addItem(menuItem)
        }
        return menu
    }

    @objc func onContextMenu(_ menuItem: NSMenuItem) {
        if (menuItem.tag == 0) {
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
