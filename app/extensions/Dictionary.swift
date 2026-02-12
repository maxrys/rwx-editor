
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary where Key: Comparable {

    @inlinable public func ordered() -> [Element] {
        self.sorted(by: { (lhs, rhs) in
            lhs.key < rhs.key
        })
    }

}
