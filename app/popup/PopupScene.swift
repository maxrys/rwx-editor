
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupScene: View {

    @StateObject private var popupState: PopupState

    private let messageBox = MessageBox()
    private let info: FSEntityInfo

    init(_ info: FSEntityInfo) {
        self.info = info
        self._popupState = StateObject(
            wrappedValue: PopupState(info)
        )
    }

    public var body: some View {
        VStack(spacing: 0) {
            PopupHead()
            PopupBody()
            PopupFoot(messageBox: self.messageBox)
            self.messageBox
        }.environmentObject(
            self.popupState
        )
    }

}
