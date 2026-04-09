
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    struct PickerColorSet {
        let text                   = Color("color Picker Custom Text")
        let border                 = Color("color Picker Custom Border")
        let background             = Color("color Picker Custom Background")
        let itemText               = Color("color Picker Custom Item Text")
        let itemBackground         = Color("color Picker Custom Item Background")
        let itemHoveringBackground = Color.accentColor.opacity(0.2)
        let itemSelectedBackground = Color.accentColor.opacity(0.5)
    }

    static let picker = PickerColorSet()

}
