
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os

final class Features {

    static public func onApply(_ messageBox: MessageBox) {
        messageBox.insert(
            type: .ok,
            title: "onApply"
        )
    }

}
