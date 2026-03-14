
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
                isFlat: false,
                flexibility: .infinity
            ) { self.popupState.resetToDefault() }

            ButtonCustom(
                NSLocalizedString("apply", comment: ""),
                isDisabled: !self.popupState.isChanged || !self.popupState.isEditable,
                isFlat: false,
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

#Preview {
    PopupFoot()
        .environmentObject(PopupState(FSEntityInfo("/private/etc/hosts")!))
        .frame(width: 300)
}
