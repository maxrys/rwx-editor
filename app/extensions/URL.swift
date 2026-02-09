
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension URL {

    static let URL_PREFIX = "file://"
    static let URL_SUFFIX = "/"

    var pathAndName: (path: String, name: String) {
        let absolute = self.absoluteString
           .trimPrefix(Self.URL_PREFIX)
           .trimSuffix(Self.URL_SUFFIX)

        let components = absolute.split(
            separator: "/",
            omittingEmptySubsequences: false
        )

        if (components.count >= 2) {
            let path = String(describing: components.dropLast().joined(separator: "/"))
            let name = String(describing: components.last!)
            return (
                path: path.hasSuffix("/") ? path : path + "/",
                name: name
            )
        }

        return (path: "/", name: "")
    }

}
