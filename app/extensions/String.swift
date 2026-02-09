
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension String {

    func trimPrefix(_ prefix: String) -> String {
        self.hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }

    func trimSuffix(_ suffix: String) -> String {
        self.hasSuffix(suffix) ? String(self.dropLast(suffix.count)) : self
    }

}
