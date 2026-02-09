
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

public enum FSType {

    case directory
    case file
    case link
    case alias
    case unknown

}

final class FSEntityInfo {

    public let fullpath: String

    init(_ fullpath: String) {
        self.fullpath = fullpath
    }

}
