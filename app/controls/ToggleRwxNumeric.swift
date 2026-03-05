
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxNumeric: View {

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
        let ownerProxy = Binding<UInt> { PermissionSubject.owner.rightGet(from: self.perms) } set: { value in self.perms = PermissionSubject.owner.rightSet(value, to: self.perms) }
        let groupProxy = Binding<UInt> { PermissionSubject.group.rightGet(from: self.perms) } set: { value in self.perms = PermissionSubject.group.rightSet(value, to: self.perms) }
        let otherProxy = Binding<UInt> { PermissionSubject.other.rightGet(from: self.perms) } set: { value in self.perms = PermissionSubject.other.rightSet(value, to: self.perms) }
        HStack(spacing: 3) {
            PickerCustom<UInt>(selected: ownerProxy, items: self.values)
            PickerCustom<UInt>(selected: groupProxy, items: self.values)
            PickerCustom<UInt>(selected: otherProxy, items: self.values)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 14.0, *) #Preview {
    @Previewable @State var perms: UInt = 0o644
    VStack(spacing: 20) {
        ToggleRwxNumeric($perms)
        Text(String(perms, radix: 8))
    }.padding(20)
}
