
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import Cocoa
import Combine
import FinderSync

final class FinderSync: FIFinderSync {

    static let MENU_TITLE_LOCALIZED = NSLocalizedString("RWX Editor Menu", comment: "")

    private var mountsCancellable: AnyCancellable?
    private var selectedURLs: [URL] {
        if let urls = FIFinderSyncController.default().selectedItemURLs() {
            return urls
        }
        return []
    }

    override init() {
        super.init()
        self.updateWatchedVolumes()
        let nc = NSWorkspace.shared.notificationCenter
        self.mountsCancellable = nc.publisher(for: NSWorkspace.didMountNotification)
            .merge(with: nc.publisher(for: NSWorkspace.didUnmountNotification))
            .sink { [weak self] _ in
                self?.updateWatchedVolumes()
            }
        Logger.customLog("FinderSync Extension launched from: \(Bundle.main.bundlePath)")
    }

    deinit {
        mountsCancellable?.cancel()
    }

    func updateWatchedVolumes() {
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
                    Logger.customLog("Open URL: \(resultURL)")
                    NSWorkspace.shared.open(
                        resultURL
                    )
                }
            }
        }
    }

}
