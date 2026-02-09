
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension UInt {

    subscript(index: UInt) -> Bool {
        get {
            (self >> index & 0b1) == 1
        }
        set(isOn) {
            if (isOn) { self |=  (0b1 << index) }
            else      { self &= ~(0b1 << index) }
        }
    }

}
