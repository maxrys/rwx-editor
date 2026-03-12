
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

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

    @Published public private(set) var items: [String: Data] = [:]
    @Published public var selectedRows: Set<Int> = []

    public var itemsOrdered: [String] {
        self.items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).map { path, data in
            path
        }
    }

    public var selectedRowsToPaths: [String] {
        let items = self.itemsOrdered
        return self.selectedRows.compactMap { index in
            items[safe: index]
        }
    }

    init() {
        self.reload()
    }

    static func hash(items: [String: Data]) -> Int {
        if (!items.isEmpty) {
            var hasher = Hasher()
            for (path, data) in items.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }) {
                hasher.combine(path)
                hasher.combine(data) }
            return hasher.finalize()
        }
        return 0
    }

    func reload() {
        let newItems = self.select()
        let newItemsHash = Self.hash(items: newItems)
        let oldItemsHash = Self.hash(items: self.items)
        Logger.customLog("Old Data Hash: \(oldItemsHash)")
        Logger.customLog("New Data Hash: \(newItemsHash)")
        if (oldItemsHash != newItemsHash) {
            self.items = newItems
            Logger.customLog("\nBookmarksState().reload()")
            BookmarksModel.dump()
        }
    }

    private func select() -> [String: Data] {
        BookmarksModel.selectAll().reduce(into: [:]) { result, modelItem in
            result[modelItem.path] = modelItem.data
        }
    }

    func insert(_ path: String, _ data: Data) {
        _ = BookmarksModel.delete([path])
        _ = BookmarksModel.insert(path: path, data: data)
        self.reload()
    }

    func delete(_ paths: [String]) {
        _ = BookmarksModel.delete(paths)
        self.reload()
    }

}
