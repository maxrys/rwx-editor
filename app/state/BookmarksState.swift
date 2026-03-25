
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI
import Combine

final class BookmarksState: ObservableObject {

    public func getBinding<T>(_ propertyName: WritableKeyPath<BookmarksState, T>) -> Binding<T> {
        var instance = self; return Binding(
            get: {             instance[keyPath: propertyName]            },
            set: { newValue in instance[keyPath: propertyName] = newValue }
        )
    }

    @Published public private(set) var items: [BookmarksFetchItem] = []
    @Published public var selectedRows: Set<Int> = []

    public var selectedRowsToPaths: [String] {
        self.selectedRows.compactMap { index in
            self.items[safe: index]?.path
        }
    }

    init() {
        self.reload()
    }

    static func hash(items: [BookmarksFetchItem]) -> Int {
        if (!items.isEmpty) {
            var hasher = Hasher()
            for item in items {
                hasher.combine(item.path)
                hasher.combine(item.data)
                hasher.combine(item.createdAt) }
            return hasher.finalize()
        }
        return 0
    }

    func reload() {
        /* sanitization */
        let newItems = BookmarksModel.selectAll().reduce(into: [BookmarksFetchItem]()) { result, item in
            if (BookmarkValue(from: item.data).info.isExpired) { self.delete([item.path]) } else {
                result.append(item)
            }
        }
        /* update if necessary */
        let newItemsHash = Self.hash(items: newItems)
        let oldItemsHash = Self.hash(items: self.items)
        Logger.customLog("Old Data Hash: \(oldItemsHash)")
        Logger.customLog("New Data Hash: \(newItemsHash)")
        if (oldItemsHash != newItemsHash) {
            self.items = newItems
            self.selectedRows.removeAll()
            Logger.customLog("\nBookmarksState().reload()")
        }
    }

    func insert(items: [(path: String, data: Data)]) -> Bool {
        defer { self.reload() }
        return items.reduce(into: true) { result, item in
            if case .success = BookmarksModel.delete([item.path]) {
                result &= BookmarksModel.insert(
                    path: item.path,
                    data: item.data
                )
            } else {
                result = false
            }
        }
    }

    func delete(_ paths: [String]) {
        if case .success = BookmarksModel.delete(paths) {
            self.reload()
        }
    }

}
