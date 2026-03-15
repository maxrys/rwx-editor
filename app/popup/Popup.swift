
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    static let FRAME_WIDTH: CGFloat = 330

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
                    if (!info.isValidbookmark) { NoBookmarkMessageView() }
                    MessageBox(self.messageBoxState)
                    PopupHead()
                    PopupBody()
                    PopupFoot()
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

    @ViewBuilder func NoBookmarkMessageView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(NSLocalizedString("Allowed directories not found", comment: ""))
                .font(.system(size: 14, weight: .bold))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .frame(maxWidth: .infinity)
                .foregroundPolyfill(Color.messageBox.text)
                .background(Color.messageBox.errorTitleBackground)
            ButtonCustom(
                NSLocalizedString("open settings", comment: ""),
                colorStyle: .custom(text: nil, background: nil),
            ) { App.appDelegate.showWindowMain() }
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(Color.messageBox.errorDescriptionBackground)
        }
    }

    @ViewBuilder func NotSupportedView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(NSLocalizedString("Object is not suppoted", comment: ""))
                .font(.system(size: 14, weight: .bold))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .frame(maxWidth: .infinity)
                .foregroundPolyfill(Color.messageBox.text)
                .background(Color.messageBox.errorTitleBackground)
            Text(self.fullpath)
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .frame(maxWidth: .infinity)
                .foregroundPolyfill(Color.messageBox.text)
                .background(Color.messageBox.errorDescriptionBackground)
        }
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
    }.frame(width: Popup.FRAME_WIDTH)
}
