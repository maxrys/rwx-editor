
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import AppKit
import CoreData

enum ExecuteResult {
    case success(affected: Int)
    case failure
}

final public class BookmarksModel: NSManagedObject {

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

    static let container: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = storageURL
        description.configuration = "Default"
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true

        var result = NSPersistentContainer(name: "Model")
        result.persistentStoreDescriptions = [description]
        result.viewContext.automaticallyMergesChangesFromParent = true
        result.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error as NSError? {
                let alert = NSAlert()
                alert.messageText = "The application will be force closed."
                alert.informativeText =
                    "Error: \(error.localizedDescription)\n\n" +
                    "You can:\n\n" +
                    "Revert to the previous version of the app\n\n" +
                    "or Try to transfer the data manually\n\n" +
                    "or Delete the conflicting storage at\n\(storageURL.path)\n" +
                    "!!! All app data will be lost !!!"
                alert.alertStyle = .critical
                alert.addButton(withTitle: "ОК")
                alert.runModal()
                NSApp.terminate(nil)
            } else {
                Logger.customLog("Storage path = \"\(storageURL.path)\"")
            }
        })
        return result
    }()

    static var context: NSManagedObjectContext {
        Self.container.viewContext
    }

    static func fetchRequest() -> NSFetchRequest<BookmarksModel> {
        NSFetchRequest<BookmarksModel>(entityName: "Bookmarks")
    }

    convenience init() {
        self.init(context: Self.context)
    }

    static func selectAll() -> [BookmarksModel] {
        do {
            let fetchRequest = Self.fetchRequest()
            let orderByPath = NSSortDescriptor(key: #keyPath(BookmarksModel.path), ascending: false)
            fetchRequest.sortDescriptors = [orderByPath]
            return try Self.context.fetch(fetchRequest)
        } catch {
            Logger.customLog("Model BookmarksModel.selectAll() error: \(error).")
            return []
        }
    }

    static func insert(path: String, data: Data) -> Bool {
        do {
            let newObject = BookmarksModel()
                newObject.path = path
                newObject.data = data
                newObject.createdAt = Int64(Date().timeIntervalSince1970)
            try Self.context.save()
            return true
        } catch {
            Logger.customLog("Model BookmarksModel.insert() error: \(error).")
            return false
        }
    }

    static func delete(_ paths: [String]) -> ExecuteResult {
        do {
            let fetchRequest = Self.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "path IN %@", paths)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            deleteRequest.resultType = .resultTypeCount
            let result = try Self.context.execute(deleteRequest) as? NSBatchDeleteResult
            let affected = result?.result as? Int ?? 0
            try Self.context.save()
            return .success(affected: affected)
        } catch {
            Logger.customLog("Model BookmarksModel.delete() error: \(error).")
            return .failure
        }
    }

    static func dump() {
        #if DEBUG
            let items = Self.selectAll()
            if (!items.isEmpty) {

                let rows: [String] = items.reduce(into: []) { result, item in
                    let formattedPath = item.path.padding(toLength: 60, withPad: " ", startingAt: 0)
                    result.append(">> - \(formattedPath)")
                }

                Logger.customLog("""

                Storage Dump for \"BookmarksModel\":
                >> ---------------------------------------------------------------------------
                >> path
                >> ===========================================================================
                \(rows.joined(separator: "\n"))
                >> ---------------------------------------------------------------------------

                """)
            } else {
                Logger.customLog("""

                Storage Dump for \"BookmarksModel\":
                >> ---------------------------------------------------------------------------
                >>                              ... no data ...
                >> ---------------------------------------------------------------------------

                """)
            }
        #endif
    }

}
