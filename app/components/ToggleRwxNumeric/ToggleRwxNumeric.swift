
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxNumeric: View {

    @Environment(\.isEnabled) private var isEnabled

    @Binding private var perms: PermissionsValue

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

    init(_ perms: Binding<PermissionsValue>) {
        self._perms = perms
    }

    public var body: some View {
        let ownerProxy = Binding<UInt> { PermissionSubject.owner.permissionGet(from: self.perms) } set: { value in self.perms = PermissionSubject.owner.permissionSet(value, to: self.perms) }
        let groupProxy = Binding<UInt> { PermissionSubject.group.permissionGet(from: self.perms) } set: { value in self.perms = PermissionSubject.group.permissionSet(value, to: self.perms) }
        let otherProxy = Binding<UInt> { PermissionSubject.other.permissionGet(from: self.perms) } set: { value in self.perms = PermissionSubject.other.permissionSet(value, to: self.perms) }
        HStack(spacing: 3) {
            PickerCustom<UInt>(selected: ownerProxy, items: self.values).disabled(!self.isEnabled)
            PickerCustom<UInt>(selected: groupProxy, items: self.values).disabled(!self.isEnabled)
            PickerCustom<UInt>(selected: otherProxy, items: self.values).disabled(!self.isEnabled)
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
    static public var previews: some View {
        ViewWithState()
    }
}
