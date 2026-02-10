
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxColored: View {

    enum ColorNames: String {
        case empty = "color ToggleRwxColored Empty"
    }

    @Binding private var rights: UInt

    private let subject: Subject
    private let bitPosition: UInt
    private let iconSize: CGFloat = 25

    private var isOn: Bool {
        self.rights[
            self.bitPosition
        ]
    }

    init(_ subject: Subject, _ rights: Binding<UInt>, bitPosition: UInt) {
        self.subject     = subject
        self._rights     = rights
        self.bitPosition = bitPosition
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
                        .frame(width: self.iconSize, height: self.iconSize)
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundPolyfill(Color.white)
                }
            } else {
                Circle()
                    .fill(Color(Self.ColorNames.empty.rawValue))
                    .frame(width: self.iconSize, height: self.iconSize)
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
    @Previewable @State var rights: UInt = 0o7
    HStack(spacing: 10) {
        ToggleRwxColored(.owner, $rights, bitPosition: Permission.r.offset)
        ToggleRwxColored(.group, $rights, bitPosition: Permission.x.offset)
        ToggleRwxColored(.other, $rights, bitPosition: Permission.w.offset)
    }.padding(20)
}
