
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupFoot: View {

    @EnvironmentObject private var popupState: PopupState

    private let messageBox: MessageBox

    init(messageBox: MessageBox) {
        self.messageBox = messageBox
    }

    public var body: some View {
        HStack(spacing: 10) {

            /* MARK: cancel button */

            ButtonCustom(
                NSLocalizedString("cancel", comment: ""),
                colorStyle: .custom(text: nil, background: nil),
                isFlat: false,
                flexibility: .size(100)
            ) { self.popupState.resetToDefault() }
            .disabled(!self.popupState.isChanged)

            /* MARK: apply button */

            ButtonCustom(
                NSLocalizedString("apply", comment: ""),
                colorStyle: .custom(text: nil, background: nil),
                isFlat: false,
                flexibility: .size(100)
            ) { self.onApply() }.disabled(false)

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.popup.foot)
    }

    private func onApply() {
        self.messageBox.insert(
            type: .ok,
            title: "onApply"
        )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    PopupFoot(messageBox: MessageBox())
        .frame(width: 300)
}
