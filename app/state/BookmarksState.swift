
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

    @Published public private(set) var data: [String: Data] = [:]
    @Published public var selectedRows: Set<Int> = []

    public var dataOrdered: [String] {
        self.data.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).map { path, data in
            path
        }
    }

    public var selectedRowsToPaths: [String] {
        let rows = self.dataOrdered
        return self.selectedRows.compactMap { index in
            rows[safe: index]
        }
    }

    init() {
        self.dataReload()
    }

    func dataReload() {
        self.data.removeAll()
        for item in BookmarksModel.selectAll() {
            self.data[item.path] = item.data
        }
        Logger.customLog("\nBookmarksState().dataReload()")
        BookmarksModel.dump()
    }

    func insert(_ path: String, _ data: Data) {
        _ = BookmarksModel.delete([path])
        _ = BookmarksModel.insert(path: path, data: data)
        self.data[path] = data
        Logger.customLog("\nBookmarksState().insert()")
        BookmarksModel.dump()
    }

    func delete(_ paths: [String]) {
        _ = BookmarksModel.delete(paths)
        for path in paths {
            self.data[path] = nil
        }
        Logger.customLog("\nBookmarksState().delete()")
        BookmarksModel.dump()
    }

}
