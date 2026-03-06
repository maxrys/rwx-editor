
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

            try FileManager.default.setAttributes(
                [.posixPermissions     : state.perms,
                 .ownerAccountName     : state.owner,
                 .groupOwnerAccountName: state.group],
                ofItemAtPath: state.info.fullpath
            )

            messageBox.insert(
                type: .ok,
                title: NSLocalizedString("completed successfully", comment: "")
            )

            return true
        } catch let error as NSError {
            messageBox.insert(
                type: .error,
                title: NSLocalizedString("completed unsuccessfully", comment: ""),
                description: error.code == 513 ? "SandBox error" : error.localizedDescription
            )
            return false
        }
    }

}
