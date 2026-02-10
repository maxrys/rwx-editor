
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupBody: View {

    enum ColorNames: String {
        case body = "color Popup Body Background"
    }

    @Binding private var rights: UInt
    @Binding private var owner: String
    @Binding private var group: String

    private let info: FSEntityInfo

    init(
        info: FSEntityInfo,
        rights: Binding<UInt>,
        owner: Binding<String>,
        group: Binding<String>
    ) {
        self.info = info
        self._rights = rights
        self._owner = owner
        self._group = group
    }

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {

            Color.clear
            Text(NSLocalizedString("Owner", comment: ""))
            Text(NSLocalizedString("Group", comment: ""))
            Text(NSLocalizedString("Other", comment: ""))

            Text(NSLocalizedString("Read", comment: ""))
            ToggleRwxColored(.owner, self.$rights, bitPosition: Subject.owner.offset + Permission.r.offset)
            ToggleRwxColored(.group, self.$rights, bitPosition: Subject.group.offset + Permission.r.offset)
            ToggleRwxColored(.other, self.$rights, bitPosition: Subject.other.offset + Permission.r.offset)

            Text(NSLocalizedString("Write", comment: ""))
            ToggleRwxColored(.owner, self.$rights, bitPosition: Subject.owner.offset + Permission.w.offset)
            ToggleRwxColored(.group, self.$rights, bitPosition: Subject.group.offset + Permission.w.offset)
            ToggleRwxColored(.other, self.$rights, bitPosition: Subject.other.offset + Permission.w.offset)

            Text(self.info.type == .file ? NSLocalizedString("Execute", comment: "") : NSLocalizedString("Access", comment: ""))
            ToggleRwxColored(.owner, self.$rights, bitPosition: Subject.owner.offset + Permission.x.offset);
            ToggleRwxColored(.group, self.$rights, bitPosition: Subject.group.offset + Permission.x.offset);
            ToggleRwxColored(.other, self.$rights, bitPosition: Subject.other.offset + Permission.x.offset);

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(Self.ColorNames.body.rawValue))
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 14.0, *) #Preview {
    @Previewable @State var info: FSEntityInfo = FSEntityInfo("/private/etc/")!
    @Previewable @State var rights: UInt       = FSEntityInfo("/private/etc/")!.rights
    @Previewable @State var owner: String      = FSEntityInfo("/private/etc/")!.owner
    @Previewable @State var group: String      = FSEntityInfo("/private/etc/")!.group
    VStack(spacing: 20) {
        PopupBody(
            info: info,
            rights: $rights,
            owner: $owner,
            group: $group
        ).frame(width: 300)
    }
    .padding(20)
    .background(Color.black)
    .frame(width: 300)
}
