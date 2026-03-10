
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    static let label: Color = {
        Color(NSColor.labelColor)
    }()

    static let selectedContentBackground: Color = {
        Color(NSColor.selectedContentBackgroundColor)
    }()

    static let selectedContentUnactiveBackground: Color = {
        Color(NSColor.unemphasizedSelectedContentBackgroundColor)
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
