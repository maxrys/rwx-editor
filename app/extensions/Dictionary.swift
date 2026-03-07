
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

extension Dictionary {

    public enum OrderBy {
        case keyAscending
        case keyDescending
        case valueAscending
        case valueDescending
    }

    public func sorted(
        order: Self.OrderBy = .keyAscending
    ) -> [Element] where Key: Comparable, Value: Comparable {
        switch order {
            case .keyAscending   : self.sorted(by: { (lhs, rhs) in lhs.key   < rhs.key   })
            case .keyDescending  : self.sorted(by: { (lhs, rhs) in lhs.key   > rhs.key   })
            case .valueAscending : self.sorted(by: { (lhs, rhs) in lhs.value < rhs.value })
            case .valueDescending: self.sorted(by: { (lhs, rhs) in lhs.value > rhs.value })
        }
    }

}
