
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxColored: View {

    enum ColorNames: String {
        case empty = "color Toggle RWX Colored Empty"
    }

    static private let ICON_SIZE: CGFloat = 25

    @Binding private var rights: UInt

    private let subject: Subject
    private let permission: Permission

    private var bitPosition: UInt {
        self.subject.offset + self.permission.offset
    }

    private var isOn: Bool {
        self.rights[
            self.bitPosition
        ]
    }

    init(subject: Subject, permission: Permission, _ rights: Binding<UInt>) {
        self.subject     = subject
        self.permission  = permission
        self._rights     = rights
    }

    var background: Color {
        switch self.subject {
            case .owner: Color.custom.softGreen
            case .group: Color.custom.softOrange
            case .other: Color.custom.softRed
        }
    }

    var body: some View {
        Button {
            self.rights[self.bitPosition].toggle()
        } label: {
            if (self.isOn) {
                ZStack {
                    Circle()
                        .fill(self.background)
                        .frame(width: Self.ICON_SIZE, height: Self.ICON_SIZE)
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundPolyfill(Color.white)
                }
            } else {
                Circle()
                    .fill(Color(Self.ColorNames.empty.rawValue))
                    .frame(width: Self.ICON_SIZE, height: Self.ICON_SIZE)
            }
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: UInt = 0o777
    HStack(spacing: 10) {
        ToggleRwxColored(subject: .owner, permission: .r, $rights)
        ToggleRwxColored(subject: .group, permission: .x, $rights)
        ToggleRwxColored(subject: .other, permission: .w, $rights)
    }.padding(20)
}
