
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

enum MessageType {

    enum ColorNames: String {
        case text                         = "color MessageBox Text"
        case infoTitleBackground          = "color MessageBox Info Title Background"
        case infoDescriptionBackground    = "color MessageBox Info Description Background"
        case okTitleBackground            = "color MessageBox Ok Title Background"
        case okDescriptionBackground      = "color MessageBox Ok Description Background"
        case warningTitleBackground       = "color MessageBox Warning Title Background"
        case warningDescriptionBackground = "color MessageBox Warning Description Background"
        case errorTitleBackground         = "color MessageBox Error Title Background"
        case errorDescriptionBackground   = "color MessageBox Error Description Background"
    }

    case info
    case ok
    case warning
    case error

    var colorTitleBackground: Color {
        switch self {
            case .info   : Color(Self.ColorNames.infoTitleBackground.rawValue)
            case .ok     : Color(Self.ColorNames.okTitleBackground.rawValue)
            case .warning: Color(Self.ColorNames.warningTitleBackground.rawValue)
            case .error  : Color(Self.ColorNames.errorTitleBackground.rawValue)
        }
    }

    var colorDescriptionBackground: Color {
        switch self {
            case .info   : Color(Self.ColorNames.infoDescriptionBackground.rawValue)
            case .ok     : Color(Self.ColorNames.okDescriptionBackground.rawValue)
            case .warning: Color(Self.ColorNames.warningDescriptionBackground.rawValue)
            case .error  : Color(Self.ColorNames.errorDescriptionBackground.rawValue)
        }
    }

}

struct Message: Hashable {

    enum LifeTime {
        case infinity
        case time(Double)
    }

    static let LIFE_TIME: Double = 3.0

    let type: MessageType
    let title: String
    let description: String

    init(type: MessageType, title: String, description: String = "") {
        self.type = type
        self.title = title
        self.description = description
    }

}

struct MessageBox: View {

    typealias MessageCollection = [UInt: (
        message: Message,
        expirationTimer: Timer.Custom?
    )]

    @ObservedObject private var messages = ValueState<MessageCollection>([:])
    @ObservedObject private var messageCurrentID = ValueState<UInt>(0)

    var body: some View {
        VStack (spacing: 0) {
            ForEach(self.messages.value.sorted(by: { (lhs, rhs) in lhs.key < rhs.key }), id: \.key) { id, item in
                VStack(spacing: 0) {
                    Text(NSLocalizedString(item.message.title, comment: ""))
                        .font(.system(size: 14, weight: .bold))
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(13)
                        .frame(maxWidth: .infinity)
                        .background(item.message.type.colorTitleBackground)
                    if (!item.message.description.isEmpty) {
                        Text(NSLocalizedString(item.message.description, comment: ""))
                            .font(.system(size: 13))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(13)
                            .frame(maxWidth: .infinity)
                            .background(item.message.type.colorDescriptionBackground)
                    }
                }
                .foregroundPolyfill(Color(MessageType.ColorNames.text.rawValue))
                .frame(maxWidth: .infinity)
            }
        }
    }

    func insert(type: MessageType, title: String, description: String = "", lifeTime: Message.LifeTime = .time(Message.LIFE_TIME)) {
        let message = Message(type: type, title: title, description: description)
        for current in self.messages.value {
            if (message == current.value.message) {
                return
            }
        }

        self.messageCurrentID.value += 1
        let id = self.messageCurrentID.value

        switch lifeTime {
            case .infinity:
                self.messages.value[id] = (
                    message: message,
                    expirationTimer: nil
                )
            case .time(let time):
                self.messages.value[id] = (
                    message: message,
                    expirationTimer: Timer.Custom(
                        tag: id,
                        repeats: .count(1),
                        delay: time,
                        onExpire: { _ in
                            self.messages.value[id] = nil
                        }
                    )
                )
        }
    }

}

#Preview {
    let messageBox: MessageBox = {
        let result = MessageBox()
            result.insert(type: .info   , title: "Info"   , lifeTime: .infinity)
            result.insert(type: .ok     , title: "Ok"     , lifeTime: .infinity)
            result.insert(type: .warning, title: "Warning", lifeTime: .infinity)
            result.insert(type: .error  , title: "Error"  , lifeTime: .infinity)
            result.insert(type: .info   , title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(3))
            result.insert(type: .ok     , title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(4))
            result.insert(type: .warning, title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(5))
            result.insert(type: .error  , title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", lifeTime: .time(6))
        return result
    }()
    ScrollView {
        messageBox
    }
    .frame(maxWidth: 300)
    .padding(10)
}
