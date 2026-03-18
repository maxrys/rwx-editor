
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupFoot: View {

    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var messageBoxState: MessageState
    @EnvironmentObject private var popupState: PopupState

    public var body: some View {
        HStack(spacing: 15) {

            ButtonCustom(
                NSLocalizedString("cancel", comment: ""),
                isDisabled: !self.popupState.isChanged || !self.popupState.isEditable,
                colorStyle: .custom(text: nil, background: nil),
                flexibility: .infinity
            ) { self.popupState.resetToDefault() }

            ButtonCustom(
                NSLocalizedString("apply", comment: ""),
                isDisabled: !self.popupState.isChanged || !self.popupState.isEditable,
                flexibility: .infinity
            ) {
                if (Features.onApply(self.messageBoxState, self.popupState)) {
                    self.popupState.resetToCurrent()
                }
            }

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            self.colorScheme == .dark ?
                Color.white.opacity(0.03) :
                Color.black.opacity(0.03)
        )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct PopupFoot_Previews: PreviewProvider {
    static var previews: some View {
        PopupFoot()
            .environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/hosts"))!))
            .frame(width: Popup.FRAME_WIDTH)
    }
}
