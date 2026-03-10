
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import AppKit
import CoreData

public class BookmarksModel: NSManagedObject {

    @NSManaged var path: String
    @NSManaged var data: Data
    @NSManaged var createdAt: Int64

    static let storageDirectoryURL: URL = {
        FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: GROUP_NAME
        )!
    }()

    static let storageURL: URL = {
        storageDirectoryURL.appendingPathComponent(STORAGE_NAME)
    }()

    static var container: NSPersistentContainer!

    static var context: NSManagedObjectContext {
        if (Self.container == nil) { Self.containerInit() }
        return Self.container.viewContext
    }

    static func fetchRequest() -> NSFetchRequest<BookmarksModel> {
        return NSFetchRequest<BookmarksModel>(entityName: "Bookmarks")
    }

    convenience init() {
        self.init(context: Self.context)
    }

    static func containerInit() {
        let description = NSPersistentStoreDescription()
        description.url = Self.storageURL
        description.configuration = "Default"
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true

        Self.container = NSPersistentContainer(name: "Model")
        Self.container.persistentStoreDescriptions = [description]
        Self.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        Self.container.viewContext.automaticallyMergesChangesFromParent = true
        Self.container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error as NSError? {
                let alert = NSAlert()
                alert.messageText = "The application will be force closed."
                alert.informativeText =
                    "Error: \(error.localizedDescription)\n\n" +
                    "You can:\n\n" +
                    "Revert to the previous version of the app\n\n" +
                    "or Try to transfer the data manually\n\n" +
                    "or Delete the conflicting storage at\n\(Self.storageURL.path)\n" +
                    "!!! All app data will be lost !!!"
                alert.alertStyle = .critical
                alert.addButton(withTitle: "ОК")
                alert.runModal()
                NSApp.terminate(nil)
            } else {
                Logger.customLog("Storage path = \"\(Self.storageURL.path)\"")
            }
        })
    }

    static func selectAll() -> [BookmarksModel] {
        do {
            let fetchRequest = Self.fetchRequest()
            let orderByPath = NSSortDescriptor(key: #keyPath(BookmarksModel.path), ascending: false)
            fetchRequest.sortDescriptors = [orderByPath]
            return try Self.context.fetch(fetchRequest)
        } catch {
            Logger.customLog("Model Self.selectAll() error: \(error).")
        }
        return []
    }

    static func dump() {
        #if DEBUG
        var renderedRows: [String] = []
        Self.selectAll().forEach { object in
            let path = object.path.padding(toLength: 60, withPad: " ", startingAt: 0)
            renderedRows.append(">> - \(path)")
        }
        if (renderedRows.isEmpty) {
            renderedRows.append(
                ">>" + String(repeating: " ", count: 30) + "... no data ..."
            )
        }
        Logger.customLog("""
        
        Storage Dump for \"BookmarksModel\":
        >> ---------------------------------------------------------------------------
        >> path
        >> ===========================================================================
        \(renderedRows.joined(separator: "\n"))
        >> ---------------------------------------------------------------------------
        
        """)
        #endif
    }

}
