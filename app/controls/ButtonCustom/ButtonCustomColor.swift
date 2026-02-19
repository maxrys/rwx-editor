
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    struct ButtonCustomColorSet {

        enum Style {

            case accent
            case danger
            case custom

            public var text: Color {
                switch self {
                    case .accent: Color.white
                    case .danger: Color.white
                    case .custom: Color("color ButtonCustom Text")
                }
            }

            public var background: Color {
                switch self {
                    case .accent: Color.accentColor
                    case .danger: Color("color ButtonCustom Background Danger")
                    case .custom: Color("color ButtonCustom Background")
                }
            }
        }

    }

}
