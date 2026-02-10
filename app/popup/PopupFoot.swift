
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupFoot: View {

    enum ColorNames: String {
        case foot = "color Popup Foot Background"
    }

    var body: some View {
        VStack(spacing: 0) {
            Text("PopupFoot")
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(Self.ColorNames.foot.rawValue))
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    PopupFoot()
}
