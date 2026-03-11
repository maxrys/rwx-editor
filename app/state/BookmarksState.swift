
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
        self.itemsReload()
    }

    static func hash(items: [String: Data]) -> Int {
        if (!items.isEmpty) {
            var hasher = Hasher()
            for (path, data) in items {
                hasher.combine(path)
                hasher.combine(data) }
            return hasher.finalize()
        }
        return 0
    }

    func itemsReload() {
        self.items.removeAll()
        for item in BookmarksModel.selectAll() {
            self.items[item.path] = item.data
        }
        Logger.customLog("\nBookmarksState().itemsReload()")
        BookmarksModel.dump()
    }

    func insert(_ path: String, _ data: Data) {
        _ = BookmarksModel.delete([path])
        _ = BookmarksModel.insert(path: path, data: data)
        self.items[path] = data
        Logger.customLog("\nBookmarksState().insert()")
        BookmarksModel.dump()
    }

    func delete(_ paths: [String]) {
        _ = BookmarksModel.delete(paths)
        for path in paths {
            self.items[path] = nil
        }
        Logger.customLog("\nBookmarksState().delete()")
        BookmarksModel.dump()
    }

}
