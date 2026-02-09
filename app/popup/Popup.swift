
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Popup: View {

    public let fullpath: String
    public let info: FSEntityInfo

    init(fullpath: String) {
        self.fullpath = fullpath
        self.info = FSEntityInfo(
            fullpath
        )
    }

    var body: some View {
        VStack (spacing: 0) {
            PopupHead(info: self.info)
            PopupBody()
            PopupFoot()
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 20) {
        Popup(fullpath: "/private/etc/")
        Popup(fullpath: "/private/etc/hosts")
    }.padding(20)
}
