
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupBody: View {

    enum ColorNames: String {
        case body = "color Popup Body Background"
    }

    public let info: FSEntityInfo

    init(info: FSEntityInfo) {
        self.info = info
    }

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {

            Color.clear
            Text(NSLocalizedString("Owner", comment: ""))
            Text(NSLocalizedString("Group", comment: ""))
            Text(NSLocalizedString("Other", comment: ""))

         // Text(NSLocalizedString("Read", comment: ""))
         // ToggleRwxColored(.owner, self.rights, bitPosition: Subject.owner.offset + Permission.r.offset)
         // ToggleRwxColored(.group, self.rights, bitPosition: Subject.group.offset + Permission.r.offset)
         // ToggleRwxColored(.other, self.rights, bitPosition: Subject.other.offset + Permission.r.offset)

         // Text(NSLocalizedString("Write", comment: ""))
         // ToggleRwxColored(.owner, self.rights, bitPosition: Subject.owner.offset + Permission.w.offset)
         // ToggleRwxColored(.group, self.rights, bitPosition: Subject.group.offset + Permission.w.offset)
         // ToggleRwxColored(.other, self.rights, bitPosition: Subject.other.offset + Permission.w.offset)

         // Text(self.info.type.wrappedValue == .file ? NSLocalizedString("Execute", comment: "") : NSLocalizedString("Access", comment: ""))
         // ToggleRwxColored(.owner, self.rights, bitPosition: Subject.owner.offset + Permission.x.offset);
         // ToggleRwxColored(.group, self.rights, bitPosition: Subject.group.offset + Permission.x.offset);
         // ToggleRwxColored(.other, self.rights, bitPosition: Subject.other.offset + Permission.x.offset);

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(Self.ColorNames.body.rawValue))
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 20) {
        PopupBody(info: FSEntityInfo("/private/etc/")!)      /* directory */
        PopupBody(info: FSEntityInfo("/private/etc/hosts")!) /* file */
    }
    .padding(20)
    .background(Color.black)
    .frame(width: 300)
}
