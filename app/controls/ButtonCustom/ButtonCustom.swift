
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ButtonCustom: View {

    typealias ColorStyle = Color.ButtonCustomColorSet.Style

    @Environment(\.colorScheme) private var colorScheme

    private let text: String
    private let disabled: Bool
    private let colorStyle: ColorStyle
    private let isFlat: Bool
    private let flexibility: Flexibility
    private let onClick: () -> Void

    init(
        _ text: String = "button",
        disabled: Bool = false,
        colorStyle: ColorStyle = .accent,
        isFlat: Bool = true,
        flexibility: Flexibility = .none,
        onClick: @escaping () -> Void = { }
    ) {
        self.text = text
        self.disabled = disabled
        self.colorStyle = colorStyle
        self.isFlat = isFlat
        self.flexibility = flexibility
        self.onClick = onClick
    }

    var body: some View {
        Button { self.onClick() } label: {
            Text(self.text)
                .lineLimit(1)
                .flexibility(self.flexibility)
                .font(.system(size: 12.5, weight: .regular))
                .foregroundPolyfill(self.colorStyle.text)
                .padding(.horizontal, 9)
                .padding(.top       , 2)
                .padding(.bottom    , 3)
                .background(
                    (self.isFlat ?
                        AnyView(RoundedRectangle(cornerRadius: 5).fill                (self.colorStyle.background)) :
                        AnyView(RoundedRectangle(cornerRadius: 5).fillGradientPolyfill(self.colorStyle.background))
                    ).shadow(
                        color: self.colorScheme == .dark ?
                            .black.opacity(1.0) :
                            .black.opacity(0.4),
                        radius: 0.7,
                        y: 0.3
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
    VStack(spacing: 20) {

        VStack {
            Text("flexibility").font(.headline)
            ButtonCustom()
            ButtonCustom(flexibility: .none)
            ButtonCustom(flexibility: .size(100))
            ButtonCustom(flexibility: .infinity)
        }

        VStack {
            Text("style").font(.headline)
            ButtonCustom(colorStyle: .accent)
            ButtonCustom(colorStyle: .danger)
            ButtonCustom(colorStyle: .custom(text: nil, background: nil))
            ButtonCustom(colorStyle: .custom(text: .white, background: .orange))
        }

    }
    .frame(width: 200)
    .padding(20)
}
