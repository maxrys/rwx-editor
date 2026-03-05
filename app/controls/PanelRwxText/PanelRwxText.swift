
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PanelRwxText: View {

    @Binding private var rights: RightsValue

    init(_ rights: Binding<RightsValue>) {
        self._rights = rights
    }

    private let bitPosition: (PermissionSubject, Permission) -> UInt = { subject, permission in
        subject.offset + permission.offset
    }

    private func isOn(_ subject: PermissionSubject, _ permission: Permission) -> Bool {
        self.rights[
            self.bitPosition(subject, permission)
        ]
    }

    public var body: some View {
        let symbolR = Permission.r.rawValue
        let symbolW = Permission.w.rawValue
        let symbolX = Permission.x.rawValue
        let text =
            "\(self.isOn(.owner, .r) ? symbolR : "-")\(self.isOn(.owner, .w) ? symbolW : "-")\(self.isOn(.owner, .x) ? symbolX : "-")" +
            "\(self.isOn(.group, .r) ? symbolR : "-")\(self.isOn(.group, .w) ? symbolW : "-")\(self.isOn(.group, .x) ? symbolX : "-")" +
            "\(self.isOn(.other, .r) ? symbolR : "-")\(self.isOn(.other, .w) ? symbolW : "-")\(self.isOn(.other, .x) ? symbolX : "-")"
        Text(text)
            .font(.system(size: 13, weight: .regular, design: .monospaced))
            .padding(.init(top: 4, leading: 9, bottom: 6, trailing: 9))
            .foregroundPolyfill(Color.panelRWXText.text)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.panelRWXText.background)
            )
            .textSelectionPolyfill()
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: RightsValue = 0o644
    HStack {
        PanelRwxText($rights)
    }.padding(20)
}
