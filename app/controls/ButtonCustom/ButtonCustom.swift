
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ButtonCustom: View {

    enum Style {

        case accent
        case custom

        var colorText: Color {
            switch self {
                case .accent: Color.white
                case .custom: Color("color ButtonCustom Text")
            }
        }

        var colorBackground: Color {
            switch self {
                case .accent: Color.accentColor
                case .custom: Color("color ButtonCustom Background")
            }
        }

    }

    @Environment(\.colorScheme) private var colorScheme

    private let text: String
    private let style: Style
    private let flexibility: Flexibility
    private let onClick: () -> Void

    init(_ text: String = "button", style: Style = .accent, flexibility: Flexibility = .none, onClick: @escaping () -> Void = { }) {
        self.text        = text
        self.style       = style
        self.flexibility = flexibility
        self.onClick     = onClick
    }

    var body: some View {
        Button { self.onClick() } label: {
            Text(self.text)
                .lineLimit(1)
                .flexibility(self.flexibility)
                .font(.system(size: 12, weight: .regular))
                .foregroundPolyfill(self.style.colorText)
                .padding(.init(top: 6, leading: 10, bottom: 7, trailing: 10))
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        .fillGradientPolyfill(self.style.colorBackground)
                        .shadow(
                            color: self.colorScheme == .dark ?
                                .black.opacity(1.0) :
                                .black.opacity(0.3),
                            radius: 1.0,
                            y: 1
                        )
                )
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack {
        ButtonCustom()
        ButtonCustom(flexibility: .none)
        ButtonCustom(flexibility: .size(100))
        ButtonCustom(flexibility: .infinity)
        ButtonCustom(style: .accent)
        ButtonCustom(style: .custom)
    }
    .frame(width: 200)
    .padding(20)
}
