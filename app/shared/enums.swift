
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

public enum Permission: String {

    case r = "r"
    case w = "w"
    case x = "x"

    var offset: UInt {
        switch self {
            case .r: return 2
            case .w: return 1
            case .x: return 0
        }
    }

}

public enum Subject {

    case owner
    case group
    case other

    var offset: UInt {
        switch self {
            case .owner: return 6
            case .group: return 3
            case .other: return 0
        }
    }

}
