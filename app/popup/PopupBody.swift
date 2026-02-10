
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupBody: View {

    enum ColorNames: String {
        case body = "color Popup Body Background"
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("PopupBody")
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(Self.ColorNames.body.rawValue))
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    PopupBody()
}
