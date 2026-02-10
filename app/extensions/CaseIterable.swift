
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension CaseIterable where Self: Equatable {

    var next: Self {
        let allCases = Self.allCases
        let index = allCases.firstIndex(of: self)!
        let nextIndex = allCases.index(after: index)
        return allCases[
            nextIndex == allCases.endIndex ? allCases.startIndex : nextIndex
        ]
    }

    mutating func roll() {
        self = self.next
    }

}
