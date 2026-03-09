
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
        return Self.container!.viewContext
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
        Self.container.viewContext.automaticallyMergesChangesFromParent = true
        Self.container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error as NSError? {
                let alert = NSAlert()
                alert.messageText = "The application will be force closed."
                alert.informativeText = "Error: \(error)\nThe database schema is outdated.\n\nTo solve the problem please delete the directory manually:\n" + Self.storageDirectoryURL.path
                alert.alertStyle = .critical
                alert.addButton(withTitle: "ОК")
                alert.runModal()
                NSApp.terminate(nil)
            } else {
                let storagePath = Self.storageURL.absoluteString.removingPercentEncoding!
                Logger.customLog("Model path = \"\(storagePath)\"")
            }
        })
    }

    static func selectAll() -> [BookmarksModel] {
        do {
            let fetchRequest = Self.fetchRequest()
            fetchRequest.sortDescriptors = []
            return try Self.context.fetch(fetchRequest)
        } catch {
            Logger.customLog("Model Self.selectAll() error: \(error).")
        }
        return []
    }

}
