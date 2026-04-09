
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension Data {

    public var toString: String {
        String(data: self, encoding: .utf8) ?? ""
    }

}
