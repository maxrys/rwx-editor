
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension URL {

    static let PREFIX_THIS_APP = "rwxEditor://"
    static let PREFIX_FILE = "file://"
    static let SUFFIX_DIRRECTORY = "/"

    public func normalized(isTrimDirSuffix: Bool = true) -> String {
        let decoded: String = self.absoluteString.removingPercentEncoding ?? self.absoluteString
        if (isTrimDirSuffix) { return decoded.trimPrefix(URL.PREFIX_THIS_APP).trimPrefix(URL.PREFIX_FILE).trimSuffix(URL.SUFFIX_DIRRECTORY) }
        else                 { return decoded.trimPrefix(URL.PREFIX_THIS_APP).trimPrefix(URL.PREFIX_FILE) }
    }

    public var pathParents: [String] {
        var result: [String] = []
        let parts = self.path.trimPrefix("/").trimSuffix("/").split(separator: "/")
        for index in (0 ..< parts.count).reversed() {
            result.append(
                "/" + parts[...index].joined(separator: "/")
            )
        }
        return result + ["/"]
    }

}
