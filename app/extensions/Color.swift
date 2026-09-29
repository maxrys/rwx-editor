
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

    enum StatusColorSet {
        static let ok      = Color("color Status Ok")
        static let warning = Color("color Status Warning")
        static let error   = Color("color Status Error")
    }

    enum FormColorSet {
        static let group = Color("color Group")
    }

    static let status = StatusColorSet.self
    static let form = FormColorSet.self

}
