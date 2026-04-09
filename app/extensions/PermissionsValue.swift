
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension PermissionsValue {

    subscript(bitPosition: UInt) -> Bool {
        get {
            (self >> bitPosition & 0b1) == 1
        }
        set(isBitOn) {
            if (isBitOn) { self |=  (0b1 << bitPosition) }
            else         { self &= ~(0b1 << bitPosition) }
        }
    }

}
