
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxNumeric: View {

    @Binding private var rights: RightsValue

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

    init(_ rights: Binding<RightsValue>) {
        self._rights = rights
    }

    let valuePack: (UInt, RightsValue, Subject) -> RightsValue = { value, rightsValue, subject in
        let bitR = value[Permission.r.offset]
        let bitW = value[Permission.w.offset]
        let bitX = value[Permission.x.offset]
        var result = rightsValue
            result[subject.offset + Permission.r.offset] = bitR
            result[subject.offset + Permission.w.offset] = bitW
            result[subject.offset + Permission.x.offset] = bitX
        return result
    }

    var body: some View {
        let ownerProxy = Binding<UInt> { Subject.owner.rightGet(from: self.rights) } set: { value in self.rights = self.valuePack(value, self.rights, .owner) }
        let groupProxy = Binding<UInt> { Subject.group.rightGet(from: self.rights) } set: { value in self.rights = self.valuePack(value, self.rights, .group) }
        let otherProxy = Binding<UInt> { Subject.other.rightGet(from: self.rights) } set: { value in self.rights = self.valuePack(value, self.rights, .other) }
        VStack {
            Text("owner \(ownerProxy.wrappedValue)")
            Text("group \(groupProxy.wrappedValue)")
            Text("other \(otherProxy.wrappedValue)")
        }
     // HStack(spacing: 3) {
     //     PickerCustom<UInt>(selected: ownerProxy, values: self.values)
     //     PickerCustom<UInt>(selected: groupProxy, values: self.values)
     //     PickerCustom<UInt>(selected: otherProxy, values: self.values)
     // }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: UInt = 0o644
    VStack(spacing: 20) {
        ToggleRwxNumeric($rights)
        Text(String(rights, radix: 8))
    }.padding(20)
}
