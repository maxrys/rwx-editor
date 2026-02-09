
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Popup: View {

    public let fullpath: String
    public let info: FSEntityInfo?

    init(fullpath: String) {
        self.fullpath = fullpath
        self.info = FSEntityInfo(
            fullpath
        )
    }

    var body: some View {
        VStack (spacing: 0) {
            if let info = self.info {
                PopupHead(info: info)
                PopupBody()
                PopupFoot()
            } else {
                Text("UNSUPPORTED TYPE")
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: 300)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 20) {
        Popup(fullpath: "")                   /* empty */
        Popup(fullpath: "/unknown/")          /* non-existent */
        Popup(fullpath: "/private/etc/")      /* directory */
        Popup(fullpath: "/private/etc/hosts") /* file */
    }.padding(20)
}
