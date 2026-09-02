
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import AppKit
import CoreData

struct BookmarksFetchItem: Equatable {
    let path: String
    let data: Data
    let createdAt: Int64
}

final public class BookmarksModel: NSManagedObject {

    typealias SELF = BookmarksModel

    static let stringName = "Bookmarks"

    @NSManaged var path: String
    @NSManaged var data: Data
    @NSManaged var createdAt: Int64

    convenience init() {
        self.init(context: Storage.context)
    }

    static func searchValid(_ url: URL) -> BookmarksFetchItem? {
        do {
            let request = NSFetchRequest<SELF>(entityName: SELF.stringName)
            request.fetchLimit = Int.max
            request.sortDescriptors = [ NSSortDescriptor(key: #keyPath(SELF.path), ascending: false) ]
            request.predicate = NSPredicate(format: "path IN %@", url.pathParents)
            for modelItem in try Storage.context.fetch(request) {
                if (BookmarkValue(from: modelItem.data).info.isExpired == false) {
                    return BookmarksFetchItem(
                        path     : modelItem.path,
                        data     : modelItem.data,
                        createdAt: modelItem.createdAt
                    )
                }
            }
            return nil
        } catch {
            Logger.customLog("Model \(SELF.stringName).search() error: \(error).")
            return nil
        }
    }

    static func selectAll(
        orderBy: String = #keyPath(SELF.path),
        ascending: Bool = true
    ) -> [BookmarksFetchItem] {
        do {
            let request = NSFetchRequest<SELF>(entityName: SELF.stringName)
            request.fetchLimit = Int.max
            request.sortDescriptors = [ NSSortDescriptor(key: orderBy, ascending: ascending) ]
            return try Storage.context.fetch(request).map { modelItem in
                BookmarksFetchItem(
                    path     : modelItem.path,
                    data     : modelItem.data,
                    createdAt: modelItem.createdAt
                )
            }
        } catch {
            Logger.customLog("Model \(SELF.stringName).selectAll() error: \(error).")
            return []
        }
    }

    static func insert(path: String, data: Data) -> Bool {
        do {
            let newObject = SELF()
                newObject.path = path
                newObject.data = data
                newObject.createdAt = Int64(Date.now)
            try Storage.context.save()
            return true
        } catch {
            Logger.customLog("Model \(SELF.stringName).insert() error: \(error).")
            return false
        }
    }

    static func delete(_ paths: [String]) -> ExecuteResult {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: SELF.stringName)
            request.predicate = NSPredicate(format: "path IN %@", paths)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            deleteRequest.resultType = .resultTypeObjectIDs
            let result = try Storage.context.execute(deleteRequest) as? NSBatchDeleteResult
            let affectedIDs = result?.result as? [NSManagedObjectID] ?? []
            if (affectedIDs.count > 0) {
                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: [NSDeletedObjectsKey: affectedIDs],
                    into: [Storage.context]
                )
            }
            return .success(
                affected: affectedIDs.count
            )
        } catch {
            Logger.customLog("Model \(SELF.stringName).delete() error: \(error).")
            return .failure
        }
    }

    static func dump() {
        #if DEBUG
            let items = SELF.selectAll()
            if (!items.isEmpty) {

                let rows: [String] = items.reduce(into: []) { result, item in
                    let formattedPath = item.path
                    result.append(">> " +
                        "\(formattedPath.toWidth(60))"
                    )
                }

                Logger.customLog("""

                Storage Dump for \"\(SELF.stringName)\":
                >> ---------------------------------------------------------------------------
                >> path
                >> ===========================================================================
                \(rows.joined(separator: "\n"))
                >> ---------------------------------------------------------------------------

                """)
            } else {
                Logger.customLog("""

                Storage Dump for \"\(SELF.stringName)\":
                >> ---------------------------------------------------------------------------
                >>                              ... no data ...
                >> ---------------------------------------------------------------------------

                """)
            }
        #endif
    }

}
