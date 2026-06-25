
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
                colorStyle: .common,
                flexibility: .infinity,
                onClick: self.onClickReset
            ).disabled(!self.popupState.isChanged || !self.popupState.isEditable)

            ButtonCustom(
                NSLocalizedString("apply", comment: ""),
                colorStyle: .accent,
                flexibility: .infinity,
                onClick: self.onClickApply
            ).disabled(!self.popupState.isChanged || !self.popupState.isEditable)

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(
            self.colorScheme == .dark ?
                Color.white.opacity(0.03) :
                Color.black.opacity(0.03)
        )
    }

    private func onClickReset() {
        self.popupState.resetToDefault()
    }

    private func onClickApply() {
        if (Features.onApply(self.messageBoxState, self.popupState)) {
            self.popupState.resetToCurrent()
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct PopupFoot_Previews: PreviewProvider {
    static public var previews: some View {
        PopupFoot()
            .environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/hosts"))!))
            .frame(width: Popup.FRAME_WIDTH)
    }
}
