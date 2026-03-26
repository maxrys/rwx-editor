
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    struct NSColorSet {
        subscript(_ keyPath: KeyPath<NSColor.Type, NSColor>) -> Color {
            Color(NSColor.self[
                keyPath: keyPath
            ])
        }
    }

    static let NS = NSColorSet()

    static let label: Color = {
        Self.NS[\.labelColor]
    }()

    static let selectedContentBackground: Color = {
        Self.NS[\.selectedContentBackgroundColor]
    }()

    static let selectedContentUnactiveBackground: Color = {
        Self.NS[\.unemphasizedSelectedContentBackgroundColor]
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
