
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

typealias MessageID = UInt
typealias MessageProgressPair = (message: Message, progress: Double)

enum MessageType: Codable {

    case info
    case ok
    case warning
    case error

    var colorTitleBackground: Color {
        switch self {
            case .info   : Color.messageBox.infoTitleBackground
            case .ok     : Color.messageBox.okTitleBackground
            case .warning: Color.messageBox.warningTitleBackground
            case .error  : Color.messageBox.errorTitleBackground
        }
    }

    var colorDescriptionBackground: Color {
        switch self {
            case .info   : Color.messageBox.infoDescriptionBackground
            case .ok     : Color.messageBox.okDescriptionBackground
            case .warning: Color.messageBox.warningDescriptionBackground
            case .error  : Color.messageBox.errorDescriptionBackground
        }
    }

}

enum MessageStatus {

    case persistent
    case inProgress(Double)
    case expired

}

enum MessageLifeTime {

    static let LIFE_TIME_DEFAULT: CFTimeInterval = 3.0

    case time(Double)
    case infinity

}
