
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

extension Equatable {

    static func equalViaMirror<T>(lhs: T, rhs: T) -> Bool {
        let mirrorLhs = Mirror(reflecting: lhs)
        let mirrorRhs = Mirror(reflecting: rhs)
        guard mirrorLhs.children.count == mirrorRhs.children.count else {
            return false
        }
        for (childLhs, childRhs) in zip(mirrorLhs.children, mirrorRhs.children) {
            if let valueLhs = childLhs.value as? AnyHashable,
               let valueRhs = childRhs.value as? AnyHashable {
                if valueLhs != valueRhs {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }

}
