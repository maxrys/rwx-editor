
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

final class BookmarkValue {

    static func search(_ path: String) -> Self? {
        if let pathParents = URL(string: path)?.pathParents {
            if let foundItem = BookmarksModel.search(pathParents) {
                return Self(from: foundItem.data)
            }
        }
        return nil
    }

    public private(set) var data: Data

    public var info: (url: URL?, isExpired: Bool) {
        var isExpired = true
        let url = try? URL(
            resolvingBookmarkData: data,
            options: [.withSecurityScope],
            relativeTo: nil,
            bookmarkDataIsStale: &isExpired
        )
        return (
            url: url,
            isExpired: isExpired
        )
    }

    init(from data: Data) {
        self.data = data
    }

    init?(from url: URL) {
        let url = try? url.bookmarkData(
            options: .withSecurityScope,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )
        if let url
             { self.data = url }
        else { return nil }
    }

    func startAccessing() -> Bool {
        let (url, isExpired) = self.info
        if let url, (!isExpired)
             { return url.startAccessingSecurityScopedResource() }
        else { return false }
    }

    func stopAccessing() {
        let (url, isExpired) = self.info
        if let url, (!isExpired) {
            url.stopAccessingSecurityScopedResource()
        }
    }

}
