
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxNumeric: View {

    private var rights: Binding<UInt>
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

    init(_ rights: Binding<UInt>) {
        self.rights = rights
    }

    let valueUnpack: (UInt, Subject) -> UInt = { rightsValue, subject in
        let bitR = rightsValue[subject.offset + Permission.r.offset]
        let bitW = rightsValue[subject.offset + Permission.w.offset]
        let bitX = rightsValue[subject.offset + Permission.x.offset]
        var result: UInt = 0
            result[Permission.r.offset] = bitR
            result[Permission.w.offset] = bitW
            result[Permission.x.offset] = bitX
        return result
    }

    let valuePack: (UInt, UInt, Subject) -> UInt = { value, rightsValue, subject in
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
        let ownerProxy = Binding<UInt> { self.valueUnpack(self.rights.wrappedValue, .owner) } set: { value in self.rights.wrappedValue = self.valuePack(value, self.rights.wrappedValue, .owner) }
        let groupProxy = Binding<UInt> { self.valueUnpack(self.rights.wrappedValue, .group) } set: { value in self.rights.wrappedValue = self.valuePack(value, self.rights.wrappedValue, .group) }
        let otherProxy = Binding<UInt> { self.valueUnpack(self.rights.wrappedValue, .other) } set: { value in self.rights.wrappedValue = self.valuePack(value, self.rights.wrappedValue, .other) }
     // HStack(spacing: 3) {
     //     PickerCustom<UInt>(selected: ownerProxy, values: self.values)
     //     PickerCustom<UInt>(selected: groupProxy, values: self.values)
     //     PickerCustom<UInt>(selected: otherProxy, values: self.values)
     // }
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: UInt = 0o644
    VStack(spacing: 20) {
        ToggleRwxNumeric($rights)
        Text(String(rights))
    }.padding(20)
}
