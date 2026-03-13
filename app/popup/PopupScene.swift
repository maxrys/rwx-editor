
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupScene: View {

    private let popupState: PopupState
    private let messageBox = MessageBox()
    private let info: FSEntityInfo

    init(_ info: FSEntityInfo) {
        self.info = info
        self.popupState = PopupState(info)
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
