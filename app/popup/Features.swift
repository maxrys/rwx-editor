
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import AppKit

final class Features {

    static public func onApply(_ messageBox: MessageBox) {
        do {
            messageBox.insert(
                type: .ok,
                title: NSLocalizedString("completed successfully", comment: "")
            )
        } catch {
            messageBox.insert(
                type: .error,
                title: NSLocalizedString("completed unsuccessfully", comment: ""),
                description: error.localizedDescription
            )
        }
    }

}
