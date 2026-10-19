
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

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
        self.sorted(by: { (lhs, rhs) in
            switch order {
                case .keyAscending   : return lhs.key   < rhs.key
                case .keyDescending  : return lhs.key   > rhs.key
                case .valueAscending : return lhs.value < rhs.value
                case .valueDescending: return lhs.value > rhs.value
            }
        })
    }

}
