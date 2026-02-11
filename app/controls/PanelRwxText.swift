
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

    static private let bitPosition: (Subject, Permission) -> UInt = { subject, permission in
        subject.offset + permission.offset
    }

    static private let isOn: (UInt, Subject, Permission) -> Bool = { rights, subject, permission in
        rights[
            Self.bitPosition(subject, permission)
        ]
    }

    var body: some View {
        let symbolR = Permission.r.rawValue
        let symbolW = Permission.w.rawValue
        let symbolX = Permission.x.rawValue
        let text =
            "\(Self.isOn(self.rights, .owner, .r) ? symbolR : "-")\(Self.isOn(self.rights, .owner, .w) ? symbolW : "-")\(Self.isOn(self.rights, .owner, .x) ? symbolX : "-")" +
            "\(Self.isOn(self.rights, .group, .r) ? symbolR : "-")\(Self.isOn(self.rights, .group, .w) ? symbolW : "-")\(Self.isOn(self.rights, .group, .x) ? symbolX : "-")" +
            "\(Self.isOn(self.rights, .other, .r) ? symbolR : "-")\(Self.isOn(self.rights, .other, .w) ? symbolW : "-")\(Self.isOn(self.rights, .other, .x) ? symbolX : "-")"
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
