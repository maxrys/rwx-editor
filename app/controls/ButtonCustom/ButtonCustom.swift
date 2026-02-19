
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ButtonCustom: View {

    typealias Style = Color.ButtonCustomColorSet.Style

    @Environment(\.colorScheme) private var colorScheme

    private let text: String
    private let disabled: Bool
    private let style: Style
    private let flexibility: Flexibility
    private let onClick: () -> Void

    init(
        _ text: String = "button",
        disabled: Bool = false,
        style: Style = .accent,
        flexibility: Flexibility = .none,
        onClick: @escaping () -> Void = { }
    ) {
        self.text = text
        self.disabled = disabled
        self.style = style
        self.flexibility = flexibility
        self.onClick = onClick
    }

    var body: some View {
        Button { self.onClick() } label: {
            Text(self.text)
                .lineLimit(1)
                .flexibility(self.flexibility)
                .font(.system(size: 12, weight: .regular))
                .foregroundPolyfill(self.style.text)
                .padding(.horizontal, 9)
                .padding(.vertical  , 5)
                .background(
                    RoundedRectangle(cornerRadius: 7)
                        //.fillGradientPolyfill(self.style.background.gradient)
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
        .disabled(self.disabled)
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
        ButtonCustom(style: .danger)
        ButtonCustom(style: .custom)
    }
    .frame(width: 200)
    .padding(20)
}
