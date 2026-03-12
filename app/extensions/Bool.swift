
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

extension Bool {

    static func &= (lhs: inout Bool, rhs: Bool) {
        lhs = lhs && rhs
    }

}
