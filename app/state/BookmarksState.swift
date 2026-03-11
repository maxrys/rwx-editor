
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import Foundation
import Combine

final class BookmarksState: ObservableObject {

    @Published public private(set) var data: [String: Data] = [:]

    init() {
    }

    func selectPaths() -> [String] {
        self.data.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }).map { path, data in
            path
        }
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
