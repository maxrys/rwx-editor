
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension URL {

    static let PREFIX_THIS_APP = "rwxEditor://"
    static let PREFIX_FILE = "file://"
    static let SUFFIX_DIRRECTORY = "/"

    public func trimmed(isTrimSuffix: Bool = true) -> String {
        if (isTrimSuffix) { return self.absoluteString.trimPrefix(URL.PREFIX_THIS_APP).trimPrefix(URL.PREFIX_FILE).trimSuffix(URL.SUFFIX_DIRRECTORY) }
        else              { return self.absoluteString.trimPrefix(URL.PREFIX_THIS_APP).trimPrefix(URL.PREFIX_FILE) }
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

    public var pathAndNamePair: (path: String, name: String) {
        let components = self.trimmed().components(
            separatedBy: "/"
        )

        if (components.count >= 2) {
            let path = components.dropLast().joined(separator: "/")
            let name = components.last!
            return (
                path: path.hasSuffix("/") ? path : path + "/",
                name: name
            )
        }

        return (path: "/", name: "")
    }

}
