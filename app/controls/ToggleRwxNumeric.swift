
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

    var body: some View {
        let ownerProxy = Binding<UInt> { Subject.owner.rightGet(from: self.rights) } set: { value in self.rights = Subject.owner.rightSet(value, to: self.rights) }
        let groupProxy = Binding<UInt> { Subject.group.rightGet(from: self.rights) } set: { value in self.rights = Subject.group.rightSet(value, to: self.rights) }
        let otherProxy = Binding<UInt> { Subject.other.rightGet(from: self.rights) } set: { value in self.rights = Subject.other.rightSet(value, to: self.rights) }
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
