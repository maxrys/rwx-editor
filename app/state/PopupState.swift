
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import Combine

final class PopupState: ObservableObject, Equatable {

    static func == (lhs: PopupState, rhs: PopupState) -> Bool {
        lhs.info == rhs.info
    }

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

    public var isChanged: Bool {
        self.perms != self.originalPerms ||
        self.owner != self.originalOwner ||
        self.group != self.originalGroup
    }

    public var messageBoxAddress: MessageBoxAddress {
        .local(
            boxID: MessageBoxID(
                Checksums.crc32(self.info.url.absoluteString)
            )
        )
    }

    public let info: FSEntityInfo
    public let originalPerms: PermissionsValue
    public let originalOwner: String
    public let originalGroup: String

    init?(_ url: URL) {
        if let info = FSEntityInfo(url) {
            self.info  = info
            self.perms = info.perms
            self.owner = info.owner
            self.group = info.group
            self.originalPerms = info.perms
            self.originalOwner = info.owner
            self.originalGroup = info.group
            self.isEditable = info.editabilityMode == .allowed
        } else {
            return nil
        }
    }

    public func resetToDefault() {
        self.perms = self.originalPerms
        self.owner = self.originalOwner
        self.group = self.originalGroup
    }

}
