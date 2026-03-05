
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

public enum PermissionSubject {

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

    func rightGet(from perms: PermissionsValue) -> UInt {
        perms >> self.offset & 0b111
    }

    func rightSet(_ value: UInt, to perms: PermissionsValue) -> PermissionsValue {
        (perms & ~(0b111 << self.offset)) | ((value & 0b111) << self.offset)
    }

}
