
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    static let FRAME_WIDTH: CGFloat = 330

    @State private var messageBoxState = MessageState()
    @State private var info: FSEntityInfo?

    private let url: URL

    var currentUserName: String? {
        ProcessInfo.processInfo.environment["USER"] ?? ""
    }

    init(_ url: URL) {
        self.url = url
        Logger.customLog("Popup init with URL.path = \(url.path)")
    }

    func refresh() {
        let newInfo = FSEntityInfo(self.url)
        if (newInfo != self.info) {
            self.info = newInfo
            Logger.customLog("Popup refresh")
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            if let info = self.info {
                VStack(spacing: 0) {
                    if (self.currentUserName != info.owner) {
                        Self.StaticMessage(
                            NSLocalizedString("you are not the owner of this object", comment: "")
                        )
                    } else if (!info.isValidbookmark) {
                        Self.StaticMessage(
                            NSLocalizedString("allowed directories not found", comment: ""),
                            ButtonCustom(
                                NSLocalizedString("open settings", comment: ""),
                                colorStyle: .custom(text: nil, background: nil)
                            ) { App.appDelegate.showWindowMain() }
                        )
                    } else {
                        MessageBox(
                            self.messageBoxState
                        )
                    }
                    PopupHead()
                    PopupBody()
                    PopupFoot()
                }
                .environmentObject(PopupState(info))
                .environmentObject(self.messageBoxState)
            } else {
                Self.StaticMessage(
                    NSLocalizedString("object is not supported", comment: ""),
                    self.url.path
                )
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: Self.FRAME_WIDTH)
        .onAppear { self.refresh() }
        .onWinBecomeForeground { window in
            if (window.ID == self.url.path) {
                self.refresh()
            }
        }
    }

    @ViewBuilder static func StaticMessage(_ title: String, _ description: String? = nil) -> some View {
        if let description { Self.StaticMessage(title, Text(description)) }
        else               { Self.StaticMessage(title, EmptyView()) }
    }

    @ViewBuilder static func StaticMessage(_ title: String, _ description: some View) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(13)
                .frame(maxWidth: .infinity)
                .foregroundPolyfill(Color.messageBox.text)
                .background(Color.messageBox.errorTitleBackground)
            description
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

struct Popup_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            Popup(URL(fileURLWithPath: "/unknown"))     ; Delimiter
            Popup(URL(fileURLWithPath: "/private/etc/")); Delimiter /* directory */
            Popup(URL(fileURLWithPath: "/private/etc/hosts"))       /* file */
        }.frame(width: Popup.FRAME_WIDTH)
    }
}

struct Popup_Messages_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            Popup.StaticMessage("Message Title")                        ; Delimiter
            Popup.StaticMessage("Message Title", "Message Description") ; Delimiter
            Popup.StaticMessage("Message Title",
                ButtonCustom("buttom", colorStyle: .custom(text: nil, background: nil))
            )
        }.frame(width: Popup.FRAME_WIDTH)
    }
}
