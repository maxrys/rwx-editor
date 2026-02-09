
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Popup: View {

    public let path: String
    public let info: String

    init(path: String) {
        self.path = path
        self.info = path
    }

    var body: some View {
        VStack (spacing: 0) {
            PopupHead()
            PopupBody()
            PopupFoot()
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        Popup(path: "/private/etc/")
        Popup(path: "/private/etc/hosts")
    }.padding(20)
}
