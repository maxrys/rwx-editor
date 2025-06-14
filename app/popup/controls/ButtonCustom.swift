
/* ################################################################## */
/* ### Copyright © 2024—2025 Maxim Rysevets. All rights reserved. ### */
/* ################################################################## */

import SwiftUI

struct ButtonCustom: View {

    enum ColorNames: String {
        case text = "color ButtonCustom Text"
    }

    private let text: String
    private let onClick: () -> Void
    private let flexibility: Flexibility

    init(_ text: String = "button", flexibility: Flexibility = .none, onClick: @escaping () -> Void = { }) {
        self.text        = text
        self.onClick     = onClick
        self.flexibility = flexibility
    }

    var body: some View {
        Button { self.onClick() } label: {
            Text(self.text)
                .lineLimit(1)
                .flexibility(self.flexibility)
                .font(.system(size: 12, weight: .bold))
                .foregroundPolyfill(Color(Self.ColorNames.text.rawValue))
                .padding(.init(top: 6, leading: 10, bottom: 7, trailing: 10))
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.accentColor,
                                        Color.accentColor.opacity(0.5)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                           )
                    }
                )
        }
        .buttonStyle(.plain)
        .onHoverCursor()
    }

}

@available(macOS 14.0, *) #Preview {
    VStack {
        ButtonCustom()
        ButtonCustom(flexibility: .none)
        ButtonCustom(flexibility: .size(100))
        ButtonCustom(flexibility: .infinity)
    }
    .frame(width: 200)
    .padding(20)
}
