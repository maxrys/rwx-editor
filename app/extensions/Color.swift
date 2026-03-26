
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    static func getNS(_ keyPath: KeyPath<NSColor.Type, NSColor>) -> Color {
        Color(NSColor.self[keyPath: keyPath])
    }

    static let label: Color = {
        Self.getNS(\.labelColor)
    }()

    static let selectedContentBackground: Color = {
        Self.getNS(\.selectedContentBackgroundColor)
    }()

    static let selectedContentUnactiveBackground: Color = {
        Self.getNS(\.unemphasizedSelectedContentBackgroundColor)
    }()

    struct StatusColorSet {
        let ok      = Color("color Status Ok")
        let warning = Color("color Status Warning")
        let error   = Color("color Status Error")
    }

    struct FormColorSet {
        let group = Color("color Group")
    }

    static let status = StatusColorSet()
    static let form = FormColorSet()

}
