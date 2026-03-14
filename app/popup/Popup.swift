
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    static let FRAME_WIDTH: CGFloat = 300

    @State private var messageBoxState = MessageState()
    @State private var info: FSEntityInfo?

    private let fullpath: String

    init(fullpath: String) {
        self.fullpath = fullpath
        Logger.customLog("Popup init with fullpath = \(fullpath)")
    }

    func refresh() {
        let newInfo = FSEntityInfo(self.fullpath)
        if (newInfo != self.info) {
            self.info = newInfo
            Logger.customLog("Popup refresh")
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            if let info = self.info {
                VStack(spacing: 0) {
                    PopupHead()
                    PopupBody()
                    PopupFoot()
                    MessageBox(self.messageBoxState)
                }
                .environmentObject(PopupState(info))
                .environmentObject(self.messageBoxState)
            } else {
                self.NotSupportedView()
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: Self.FRAME_WIDTH)
        .onAppear { self.refresh() }
        .onWinBecomeForeground { window in
            if (window.ID == self.fullpath) {
                self.refresh()
            }
        }
    }

    @ViewBuilder func NotSupportedView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(NSLocalizedString("Object is not suppoted", comment: ""))
                .padding(20)
                .font(.system(size: 14, weight: .bold))
                .frame(maxWidth: .infinity)
                .background(Color.messageBox.errorTitleBackground)
            Text(self.fullpath)
                .padding(10)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity)
                .background(Color.messageBox.errorDescriptionBackground)
        }.foregroundPolyfill(Color.white)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 0) {
        let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
        Popup(fullpath: "/unknown")     ; Delimiter
        Popup(fullpath: "/private/etc/"); Delimiter /* directory */
        Popup(fullpath: "/private/etc/hosts")       /* file */
    }.frame(width: 300)
}
