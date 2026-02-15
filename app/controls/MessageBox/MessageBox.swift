
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct MessageBox: View {

    enum LifeTime {
        case time(Double)
        case infinity
    }

    static let LIFE_TIME_DEFAULT: CFTimeInterval = 3.0

    @ObservedObject private var data = MessageStorage()

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack (spacing: 0) {
                    ForEach(self.data.messages, id: \.key) { ID, message in
                        VStack(alignment: .leading, spacing: 0) {
                            
                            self.Title(message)
                                .overlayPolyfill(alignment: .topTrailing) {
                                    if (message.isClosable) {
                                        self.ButtonClose(ID)
                                    }
                                }

                            if (!message.description.isEmpty) {
                                self.Description(message)
                            }

                        }.overlayPolyfill(alignment: .bottomLeading) {
                            if let _ = message.expiresAt {
                                self.Progress(
                                    width: geometry.size.width * data.progress(ID)
                                )
                            }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder private func Title(_ message: Message) -> some View {
        Text(message.title)
            .font(.system(size: 14, weight: .bold))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(message.type.colorTitleBackground)
    }

    @ViewBuilder private func Description(_ message: Message) -> some View {
        Text(message.description)
            .font(.system(size: 13))
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(13)
            .frame(maxWidth: .infinity)
            .foregroundPolyfill(Color.messageBox.text)
            .background(message.type.colorDescriptionBackground)
    }

    @ViewBuilder private func Progress(width: CGFloat) -> some View {
        Color.black.opacity(0.3)
            .frame(width: width, height: 3)
    }

    @ViewBuilder private func ButtonClose(_ ID: MessageID) -> some View {
        Button {
            self.data.delete(ID)
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
        lifeTime: Self.LifeTime = .time(Self.LIFE_TIME_DEFAULT)
    ) {
        switch lifeTime {
            case .time(let time): self.data.insert(type: type, title: title, description: description, isClosable: isClosable, expiresAt: CACurrentMediaTime() + time)
            case .infinity      : self.data.insert(type: type, title: title, description: description, isClosable: isClosable)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    let longTitle       = NSLocalizedString("Long long long long long long long long long long long long long long Title", comment: "")
    let longDescription = NSLocalizedString("Long long long long long long long long long long long long long long long long long long long long long Description", comment: "")
    let messageBox      = MessageBox()
    messageBox
        .frame(width: 300, height: 700)
        .onAppear {
            messageBox.insert(type: .info   , title: NSLocalizedString("Info"   , comment: ""), lifeTime: .time(10))
            messageBox.insert(type: .ok     , title: NSLocalizedString("Ok"     , comment: ""), lifeTime: .time(20))
            messageBox.insert(type: .warning, title: NSLocalizedString("Warning", comment: ""), lifeTime: .time(30))
            messageBox.insert(type: .error  , title: NSLocalizedString("Error"  , comment: ""), lifeTime: .time(40))
            messageBox.insert(type: .info   , title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
            messageBox.insert(type: .ok     , title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
            messageBox.insert(type: .warning, title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
            messageBox.insert(type: .error  , title: longTitle, description: longDescription, isClosable: true, lifeTime: .infinity)
        }
}
