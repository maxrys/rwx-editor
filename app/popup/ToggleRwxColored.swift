
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxColored: View {

    enum ColorNames: String {
        case empty = "color ToggleRwxColored Empty"
    }

    enum Kind {
        case owner
        case group
        case other
    }

    private var kind: Kind
    private var rights: Binding<UInt>
    private var bitPosition: UInt
    private let iconR: CGFloat = 25
    private var isOn: Bool {
        self.rights.wrappedValue.bitGet(
            position: self.bitPosition
        ) == 1
    }

    init(_ kind: Kind, _ rights: Binding<UInt>, bitPosition: UInt) {
        self.kind        = kind
        self.rights      = rights
        self.bitPosition = bitPosition
    }

    var background: Color {
        switch self.kind {
            case .owner: Color.getCustom(.softGreen)
            case .group: Color.getCustom(.softOrange)
            case .other: Color.getCustom(.softRed)
        }
    }

    var body: some View {
        Button {
            self.rights.wrappedValue.bitToggle(
                position: self.bitPosition
            )
        } label: {
            if (self.isOn) {
                ZStack {
                    Circle()
                        .fill(self.background)
                        .frame(width: self.iconR, height: self.iconR)
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundPolyfill(Color.white)
                }
            } else {
                Circle()
                    .fill(Color(Self.ColorNames.empty.rawValue))
                    .frame(width: self.iconR, height: self.iconR)
            }
        }
        .buttonStyle(.plain)
        .onHoverCursor()
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: UInt = 0o7
    HStack(spacing: 10) {
        ToggleRwxColored(.owner, $rights, bitPosition: Permission.r.offset)
        ToggleRwxColored(.group, $rights, bitPosition: Permission.x.offset)
        ToggleRwxColored(.other, $rights, bitPosition: Permission.w.offset)
    }.padding(20)
}
