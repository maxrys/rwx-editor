
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Popup: View {

    @State private var rights: UInt
    @State private var owner: String
    @State private var group: String

    private let fullpath: String
    private let info: FSEntityInfo

    init?(fullpath: String) {
        guard let info = FSEntityInfo(fullpath) else {
            return nil
        }
        self.fullpath = fullpath
        self.info   = info
        self.rights = info.rights
        self.owner  = info.owner
        self.group  = info.group
    }

    var body: some View {
        VStack (spacing: 0) {

            /* MARK: head */

            PopupHead(
                self.info
            )

            /* MARK: body */

            PopupBody(
                self.info,
                self.$rights,
                self.$owner,
                self.$group
            )

            /* MARK: foot */

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
