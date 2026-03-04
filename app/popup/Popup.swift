
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    @StateObject private var popupState: PopupState

    private let messageBox = MessageBox()

    init?(fullpath: String) {
        Logger.customLog("Popup init with fullpath = \(fullpath)")
        guard let state = PopupState(fullpath: fullpath) else {
            return nil
        }
        self._popupState = StateObject(
            wrappedValue: state
        )
    }

    public var body: some View {
        VStack (spacing: 0) {
            PopupHead()
            PopupBody()
            PopupFoot(messageBox: self.messageBox)
            self.messageBox
        }
        .environmentObject(self.popupState)
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: 300)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        Popup(fullpath: "")                   /* empty */
        Popup(fullpath: "/private/etc/")      /* directory */
        Popup(fullpath: "/private/etc/hosts") /* file */
    }
    .padding(10)
    .background(Color.black)
}
