
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxNumeric: View {

    @Binding private var perms: PermissionsValue

    private let isDisabled: Bool
    private let values: [UInt: String] = [
        0: "0",
        1: "1",
        2: "2",
        3: "3",
        4: "4",
        5: "5",
        6: "6",
        7: "7",
    ]

    init(_ perms: Binding<PermissionsValue>, isDisabled: Bool = false) {
        self._perms = perms
        self.isDisabled = isDisabled
    }

    public var body: some View {
        let ownerProxy = Binding<UInt> { PermissionSubject.owner.permissionGet(from: self.perms) } set: { value in self.perms = PermissionSubject.owner.permissionSet(value, to: self.perms) }
        let groupProxy = Binding<UInt> { PermissionSubject.group.permissionGet(from: self.perms) } set: { value in self.perms = PermissionSubject.group.permissionSet(value, to: self.perms) }
        let otherProxy = Binding<UInt> { PermissionSubject.other.permissionGet(from: self.perms) } set: { value in self.perms = PermissionSubject.other.permissionSet(value, to: self.perms) }
        HStack(spacing: 3) {
            PickerCustom<UInt>(selected: ownerProxy, items: self.values, isDisabled: self.isDisabled)
            PickerCustom<UInt>(selected: groupProxy, items: self.values, isDisabled: self.isDisabled)
            PickerCustom<UInt>(selected: otherProxy, items: self.values, isDisabled: self.isDisabled)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct ToggleRwxNumeric_Previews: PreviewProvider {
    struct ViewWithState: View {
        @State private var perms: UInt = 0o644
        public var body: some View {
            VStack(spacing: 20) {
                ToggleRwxNumeric(self.$perms)
                Text(String(self.perms, radix: 8))
            }.padding(20)
        }
    }
    static var previews: some View {
        ViewWithState()
    }
}
