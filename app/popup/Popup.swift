
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Popup: View {

    public let fullpath: String
    public let info: FSEntityInfo

    init?(fullpath: String) {
        guard let info = FSEntityInfo(fullpath) else {
            return nil
        }
        self.fullpath = fullpath
        self.info = info
    }

    var body: some View {
        VStack (spacing: 0) {
            PopupHead(info: self.info)
            PopupBody(info: self.info)
            PopupFoot()
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
        Popup(fullpath: "/private/etc/")      /* directory */
        Popup(fullpath: "/private/etc/hosts") /* file */
    }
    .padding(20)
    .background(Color.black)
}
