
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    enum PickerColorSet {
        static let text                   = Color("color PickerCustom Text")
        static let border                 = Color("color PickerCustom Border")
        static let background             = Color("color PickerCustom Background")
        static let itemText               = Color("color PickerCustom Item Text")
        static let itemBackground         = Color("color PickerCustom Item Background")
        static let itemHoveringBackground = Color.accentColor.opacity(0.2)
        static let itemSelectedBackground = Color.accentColor.opacity(0.5)
    }

    static let picker = PickerColorSet.self

}
