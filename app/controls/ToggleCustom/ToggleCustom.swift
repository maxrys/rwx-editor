
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleCustom: View {

    @Binding private var isOn: Bool

    private let text: String?
    private let isFlexible: Bool
    private let size: CGSize
    private let innerPadding: CGFloat

    init(
        text: String? = nil,
        isOn: Binding<Bool>,
        isFlexible: Bool = false,
        size: CGSize = CGSize(width: 40, height: 16),
        innerPadding: CGFloat = 3
    ) {
        self.text = text
        self._isOn = isOn
        self.isFlexible = isFlexible
        self.size = size
        self.innerPadding = innerPadding
    }

    public var body: some View {
        if let text = self.text {
            if (self.isFlexible) {
                HStack {
                    self.TextView(text); Spacer()
                    self.SwitcherView()
                }.frame(maxWidth: .infinity)
            } else {
                HStack {
                    self.TextView(text)
                    self.SwitcherView()
                }
            }
        } else {
            self.SwitcherView()
        }
    }

    @ViewBuilder private func TextView(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 14))
    }

    @ViewBuilder private func SwitcherView() -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.1)) {
                self.isOn.toggle()
            }
        } label: {
            ZStack(alignment: self.isOn ? .trailing : .leading) {
                Capsule()
                    .fill(self.isOn ? .green : .black.opacity(0.3))
                    .frame(width: self.size.width, height: self.size.height)
                Capsule()
                    .fill(.white)
                    .frame(
                        width: (self.size.height * 1.5) - (self.innerPadding * 2),
                        height: self.size.height        - (self.innerPadding * 2)
                    )
                    .padding(self.innerPadding)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 2.0
                    )
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
    @Previewable @State var isOn: Bool = false
    VStack(alignment: .trailing) {
        ToggleCustom(text: "Test", isOn: $isOn, isFlexible: true)
        ToggleCustom(text: "Test", isOn: $isOn, isFlexible: false)
        ToggleCustom(isOn: $isOn)
    }
    .frame(width: 200)
    .padding(20)
}
