
/* ################################################################## */
/* ### Copyright © 2024—2026 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI
import Combine

final class PopupState: ObservableObject {

    public func getBinding<T>(_ propertyName: WritableKeyPath<PopupState, T>) -> Binding<T> {
        var instance = self; return Binding(
            get: {             instance[keyPath: propertyName]            },
            set: { newValue in instance[keyPath: propertyName] = newValue }
        )
    }

    private let originalPerms: PermissionsValue
    private let originalOwner: String
    private let originalGroup: String

    @Published var perms: PermissionsValue
    @Published var owner: String
    @Published var group: String

    let fullpath: String
    let info: FSEntityInfo

    init?(fullpath: String) {
        guard let info = FSEntityInfo(fullpath) else {
            return nil
        }
        self.fullpath = fullpath
        self.info   = info
        self.perms = info.perms
        self.owner = info.owner
        self.group = info.group
        self.originalPerms = info.perms
        self.originalOwner = info.owner
        self.originalGroup = info.group
    }

}
