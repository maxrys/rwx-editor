
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import os
import AppKit

final class Features {

    static public func onApply(_ messageBoxState: MessageState, _ state: PopupState) -> Bool {
        do {

            Logger.customLog("Popup onApply before" +
                " | fullpath = \(state.info.fullpath)" +
                " | perms = \(String(state.perms, radix: 8))" +
                " | owner = \(state.owner)" +
                " | group = \(state.group)"
            )

            if let bookmark = BookmarkValue(searchValidBy: state.info.fullpath) {
                if (!bookmark.info.isExpired) {
                    if (bookmark.startAccessing()) {

                        defer { bookmark.stopAccessing() }

                        try FileManager.default.setAttributes(
                            [.posixPermissions     : state.perms,
                             .ownerAccountName     : state.owner,
                             .groupOwnerAccountName: state.group],
                            ofItemAtPath: state.info.fullpath
                        )

                        messageBoxState.insert(
                            type: .ok,
                            title: NSLocalizedString("completed successfully", comment: "")
                        )

                        return true
                    }
                }
            }

            return false
        } catch let error as NSError {
            messageBoxState.insert(
                type: .error,
                title: NSLocalizedString("completed unsuccessfully", comment: ""),
                description: error.localizedDescription
            )
            return false
        }
    }

}
