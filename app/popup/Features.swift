
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import AppKit

final class Features {

    static public func onApply(_ messageBox: MessageBox, _ state: PopupState) -> Bool {
        do {

            Logger.customLog("Popup onApply before" +
                " | fullpath = \(state.info.fullpath)" +
                " | perms = \(String(state.perms, radix: 8))" +
                " | owner = \(state.owner)" +
                " | group = \(state.group)"
            )

            let objectURL = URL(fileURLWithPath: state.info.fullpath)
            try FileManager.default.setAttributes(
                [.posixPermissions     : state.perms,
                 .ownerAccountName     : state.owner,
                 .groupOwnerAccountName: state.group],
                ofItemAtPath: objectURL.path
            )

            messageBox.insert(
                type: .ok,
                title: NSLocalizedString("completed successfully", comment: "")
            )

            return true
        } catch {
            messageBox.insert(
                type: .error,
                title: NSLocalizedString("completed unsuccessfully", comment: ""),
                description: error.localizedDescription
            )
            return false
        }
    }

}
