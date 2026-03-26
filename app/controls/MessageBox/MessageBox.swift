
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MessageBox: View {

    @ObservedObject private var state: MessageState

    init(_ state: MessageState? = nil) {
        if let state
             { self.state = state }
        else { self.state = MessageState() }
    }

    public var body: some View {
        GeometryReaderPolyfill(isIgnoreHeight: true) { size in
            VStack (spacing: 0) {
                ForEach(self.state.messages, id: \.key) { ID, message in
                    VStack(alignment: .leading, spacing: 0) {

                        self.TitleView(message)
                            .overlayPolyfill(alignment: .topTrailing) {
                                if (message.isClosable) {
                                    self.ButtonCloseView(ID)
                                }
                            }

                        if (!message.description.isEmpty) {
                            self.DescriptionView(message)
                        }

                    }.overlayPolyfill(alignment: .bottomLeading) {
                        if let _ = message.expiresAt {
                            self.ProgressView(
                                width: size.width * self.state.progress(ID)
                            )
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder private func TitleView(_ message: Message) -> some View {
        Text(message.title)
            .font(.system(size: 14, weight: .bold))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(message.type.colorTitleBackground)
    }

    @ViewBuilder private func DescriptionView(_ message: Message) -> some View {
        Text(message.description)
            .font(.system(size: 13))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(message.type.colorDescriptionBackground)
    }

    @ViewBuilder private func ProgressView(width: CGFloat) -> some View {
        Color.black.opacity(0.3)
            .frame(width: width, height: 3)
    }

    @ViewBuilder private func ButtonCloseView(_ ID: MessageID) -> some View {
        Button {
            self.state.delete(ID)
        } label: {
            Color.white.opacity(0.1)
                .frame(width: 15, height: 15)
                .overlayPolyfill {
                    Image(systemName: "xmark")
                        .font(.system(size: 10))
                        .foregroundPolyfill(.white.opacity(0.5))
                }
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

    public func insert(
        type: MessageType,
        title: String,
        description: String = "",
        isClosable: Bool = false,
        lifeTime: MessageLifeTime = .time(MessageLifeTime.LIFE_TIME_DEFAULT)
    ) {
        self.state.insert(
            type: type,
            title: title,
            description: description,
            isClosable: isClosable,
            lifeTime: lifeTime
        )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

fileprivate let PREVIEW_LONG_TITLE       = NSLocalizedString("Long long long long long long long long long long long long long long Title", comment: "")
fileprivate let PREVIEW_LONG_DESCRIPTION = NSLocalizedString("Long long long long long long long long long long long long long long long long long long long long long Description", comment: "")

struct MessageBox_Previews1: PreviewProvider {
    static var previews: some View {
        let messageBox = MessageBox()
        messageBox
            .frame(width: 300, height: 700)
            .onAppear {
                messageBox.insert(type: .info   , title: NSLocalizedString("Info"   , comment: ""), lifeTime: .time(10))
                messageBox.insert(type: .ok     , title: NSLocalizedString("Ok"     , comment: ""), lifeTime: .time(20))
                messageBox.insert(type: .warning, title: NSLocalizedString("Warning", comment: ""), lifeTime: .time(30))
                messageBox.insert(type: .error  , title: NSLocalizedString("Error"  , comment: ""), lifeTime: .time(40))
                messageBox.insert(type: .info   , title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
                messageBox.insert(type: .ok     , title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
                messageBox.insert(type: .warning, title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
                messageBox.insert(type: .error  , title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
            }
    }
}

struct MessageBox_Previews2: PreviewProvider {
    static var previews: some View {
        let state = MessageState()
        MessageBox(state)
            .frame(width: 300, height: 700)
            .onAppear {
                state.insert(type: .info   , title: NSLocalizedString("Info"   , comment: ""), lifeTime: .time(10))
                state.insert(type: .ok     , title: NSLocalizedString("Ok"     , comment: ""), lifeTime: .time(20))
                state.insert(type: .warning, title: NSLocalizedString("Warning", comment: ""), lifeTime: .time(30))
                state.insert(type: .error  , title: NSLocalizedString("Error"  , comment: ""), lifeTime: .time(40))
                state.insert(type: .info   , title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
                state.insert(type: .ok     , title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
                state.insert(type: .warning, title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
                state.insert(type: .error  , title: PREVIEW_LONG_TITLE, description: PREVIEW_LONG_DESCRIPTION, isClosable: true, lifeTime: .infinity)
            }
    }
}
