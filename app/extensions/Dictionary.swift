
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary {

    public enum SortedBy {
        case keyAsc
        case keyDsc
        case valueAsc
        case valueDsc
    }

    public func sortedBy(order: Self.SortedBy = .keyAsc) -> [Element] where Key: Comparable, Value: Comparable {
        self.sorted(by: { (lhs, rhs) in
            switch order {
                case .keyAsc  : lhs.key   < rhs.key
                case .keyDsc  : lhs.key   > rhs.key
                case .valueAsc: lhs.value < rhs.value
                case .valueDsc: lhs.value > rhs.value
            }
        })
    }

}
