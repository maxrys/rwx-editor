
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

final class AliasValue {

    public private(set) var data: Data

    public var realUrl: URL? {
        var isExpired = true
        return try? URL(
            resolvingBookmarkData: self.data,
            options: [.withoutUI, .withoutMounting],
            relativeTo: nil,
            bookmarkDataIsStale: &isExpired
        )
    }

    init?(from url: URL) {
        if let data = try? URL.bookmarkData(withContentsOf: url)
             { self.data = data }
        else { return nil }
    }

}
