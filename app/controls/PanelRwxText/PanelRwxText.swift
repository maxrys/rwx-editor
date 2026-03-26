
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PanelRwxText: View {

    @Binding private var perms: PermissionsValue

    init(_ perms: Binding<PermissionsValue>) {
        self._perms = perms
    }

    private let bitPosition: (PermissionSubject, Permission) -> UInt = { subject, permission in
        subject.offset + permission.offset
    }

    private func isOn(_ subject: PermissionSubject, _ permission: Permission) -> Bool {
        self.perms[
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

struct PanelRwxText_Previews: PreviewProvider {
    struct ViewWithState: View {
        @State private var perms: UInt = 0o644
        public var body: some View {
            HStack {
                PanelRwxText(self.$perms)
            }.padding(20)
        }
    }
    static public var previews: some View {
        ViewWithState()
    }
}
