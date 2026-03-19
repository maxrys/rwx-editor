
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

    @Published var perms: PermissionsValue
    @Published var owner: String
    @Published var group: String
    @Published var isEditable: Bool

    public let info: FSEntityInfo
    public private(set) var originalPerms: PermissionsValue
    public private(set) var originalOwner: String
    public private(set) var originalGroup: String

    public var isChanged: Bool {
        self.perms != self.originalPerms ||
        self.owner != self.originalOwner ||
        self.group != self.originalGroup
    }

    init(_ info: FSEntityInfo) {
        self.info  = info
        self.perms = info.perms
        self.owner = info.owner
        self.group = info.group
        self.originalPerms = info.perms
        self.originalOwner = info.owner
        self.originalGroup = info.group
        self.isEditable = info.editabilityMode == .allowed
    }

    public func resetToDefault() {
        self.perms = self.originalPerms
        self.owner = self.originalOwner
        self.group = self.originalGroup
    }

    public func resetToCurrent() {
        self.originalPerms = self.perms
        self.originalOwner = self.owner
        self.originalGroup = self.group
    }

}
