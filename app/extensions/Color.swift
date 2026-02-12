
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension Color {

    struct CustomColorSet {
        let text       = Color("color Custom Text")
        let softGreen  = Color("color Custom Soft Green")
        let softOrange = Color("color Custom Soft Orange")
        let softRed    = Color("color Custom Soft Red")
        let darkGreen  = Color("color Custom Dark Green")
        let darkOrange = Color("color Custom Dark Orange")
        let darkRed    = Color("color Custom Dark Red")
    }

    static let custom = CustomColorSet()

}

/* Picker Custom */

extension Color {

    struct PickerColorSet {
        let text           = Color("color Picker Custom Text")
        let border         = Color("color Picker Custom Border")
        let background     = Color("color Picker Custom Background")
        let itemText       = Color("color Picker Custom Item Text")
        let itemBackground = Color("color Picker Custom Item Background")
    }

    static let picker = PickerColorSet()

}
