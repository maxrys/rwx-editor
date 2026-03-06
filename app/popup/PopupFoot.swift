
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
                isFlat: false,
                flexibility: .size(100)
            ) { Features.onApply(self.messageBox, self.popupState) }
            .disabled(!self.popupState.isChanged)

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.popup.foot)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    PopupFoot(messageBox: MessageBox())
        .environmentObject(PopupState(FSEntityInfo("/private/etc/hosts")!))
        .frame(width: 300)
}
