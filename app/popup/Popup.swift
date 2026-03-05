
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    static let FRAME_WIDTH: CGFloat = 300

    private let messageBox = MessageBox()
    private let fullpath: String
    private var info: FSEntityInfo?
    private var popupState: PopupState?

    init(fullpath: String) {
        Logger.customLog("Popup init with fullpath = \(fullpath)")
        self.fullpath = fullpath
        self.infoRefresh()
    }

    mutating func infoRefresh() {
        self.info = FSEntityInfo(self.fullpath)
        if let info = self.info
             { self.popupState = PopupState(info) }
        else { self.popupState = nil }
    }

    public var body: some View {
        Group {
            if let popupState = self.popupState {
                VStack(spacing: 0) {
                    PopupHead()
                    PopupBody()
                    PopupFoot(messageBox: self.messageBox)
                    self.messageBox
                }.environmentObject(popupState)
            } else {
                Text("UNKNOWN OBJECT")
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Color.popup.body)
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: Self.FRAME_WIDTH)
        .onAppBecomeForeground {
            // self.infoRefresh()
        }
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
