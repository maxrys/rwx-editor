
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PanelRwxText: View {

    enum ColorNames: String {
        case text       = "color Panel RWX Text Text"
        case background = "color Panel RWX Text Background"
    }

    @Binding private var rights: UInt

    init(_ rights: Binding<UInt>) {
        self._rights = rights
    }

    private let bitPosition: (Subject, Permission) -> UInt = { subject, permission in
        subject.offset + permission.offset
    }

    private func isOn(_ subject: Subject, _ permission: Permission) -> Bool {
        self.rights[
            self.bitPosition(subject, permission)
        ]
    }

    var body: some View {
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
            .foregroundPolyfill(Color(Self.ColorNames.text.rawValue))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(Self.ColorNames.background.rawValue))
            )
            .textSelectionPolyfill()
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: UInt = 0o644
    HStack {
        PanelRwxText($rights)
    }.padding(20)
}
