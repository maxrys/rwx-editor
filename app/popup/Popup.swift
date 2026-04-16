
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    static let TERMINAL_PATH = "file:///System/Applications/Utilities/Terminal.app/"
    static let FRAME_WIDTH: CGFloat = 330

    @State private var messageBoxState = MessageState()
    @State private var info: FSEntityInfo?

    private let url: URL

    init(_ url: URL) {
        self.url = url
        Logger.customLog("Popup init with URL.path: \(url.path)")
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
                    Group {
                        switch info.editabilityMode {
                            case .notOwner:
                                if let myName = Process.currentUserName {
                                    Self.StaticMessage(
                                        NSLocalizedString("you are not the owner of this object", comment: ""),
                                        Self.MessageDescriptionIfNotOwner(
                                            owner: myName,
                                            fullPath: url.path
                                        )
                                    )
                                } else {
                                    Self.StaticMessage(
                                        NSLocalizedString("you are not the owner of this object", comment: "")
                                    )
                                }
                            case .noBookmark:
                                Self.StaticMessage(
                                    NSLocalizedString("allowed directories not found", comment: ""),
                                    Self.MessageDescriptionIfNeedOpenSettings()
                                )
                            case .allowed:
                                MessageBox(
                                    self.messageBoxState
                                )
                        }
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
            if (window.ID == "\(WINDOW_POPUP_ID_PREFIX)\(self.url.path)") {
                self.refresh()
            }
        }
    }

    @ViewBuilder static public func MessageDescriptionIfNotOwner(owner: String, fullPath: String) -> some View {
        VStack(alignment: .center, spacing: 10) {

            let terminalCommand = "sudo chown \(owner) \"\(fullPath)\""

            Text(NSLocalizedString("Terminal command to take ownership:", comment: ""))
                .font(.system(size: 13, weight: .bold))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)

            Text("\(terminalCommand)", comment: "")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(.system(size: 11, design: .monospaced))
                .padding(.init(top: 4, leading: 9, bottom: 6, trailing: 9))
                .textSelectionPolyfill()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.black.opacity(0.1))
                )

            HStack(spacing: 10) {

                ButtonCustom(
                    NSLocalizedString("copy Command", comment: ""),
                    colorStyle: .common,
                    fixedColorScheme: .light
                ) {
                    let pasteboard = NSPasteboard.general
                    pasteboard.clearContents()
                    pasteboard.setString(terminalCommand, forType: .string)
                }

                if let termanalURL = URL(string: Self.TERMINAL_PATH) {
                    ButtonCustom(
                        NSLocalizedString("open Terminal", comment: ""),
                        colorStyle: .common,
                        fixedColorScheme: .light
                    ) { NSApplication.open(termanalURL) }
                }

            }
        }
    }

    @ViewBuilder static public func MessageDescriptionIfNeedOpenSettings() -> some View {
        ButtonCustom(
            NSLocalizedString("open settings", comment: ""),
            colorStyle: .common,
            fixedColorScheme: .light
        ) { App.appDelegate.showWindowMain() }
    }

    @ViewBuilder static public func StaticMessage(_ title: String, _ description: String? = nil) -> some View {
        if let description { Self.StaticMessage(title, Text(description)) }
        else               { Self.StaticMessage(title, EmptyView()) }
    }

    @ViewBuilder static public func StaticMessage(_ title: String, _ description: some View) -> some View {
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
    static public var previews: some View {
        VStack(spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            Popup(URL(fileURLWithPath: "/unknown"))     ; Delimiter
            Popup(URL(fileURLWithPath: "/private/etc/")); Delimiter /* directory */
            Popup(URL(fileURLWithPath: "/private/etc/hosts"))       /* file */
        }.frame(width: Popup.FRAME_WIDTH)
    }
}

struct Popup_Messages_Previews: PreviewProvider {
    static public var previews: some View {
        VStack(spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            Popup.StaticMessage("Message Title")                        ; Delimiter
            Popup.StaticMessage("Message Title", "Message Description") ; Delimiter
            Popup.StaticMessage("Message Title",
                ButtonCustom(
                    "button",
                    colorStyle: .common,
                    fixedColorScheme: .light
                )
            )
        }.frame(width: Popup.FRAME_WIDTH)
    }
}
