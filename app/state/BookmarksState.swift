
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

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
    }

    func insert(_ path: String, _ data: Data) {
        self.data[path] = data
    }

    func delete(_ paths: [String]) {
        for path in paths {
            self.data[path] = nil
        }
    }

}
