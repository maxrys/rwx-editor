
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupHead: View {

    public let info: FSEntityInfo

    var body: some View {
        Text(self.info.fullpath)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 20) {
        PopupHead(info: FSEntityInfo("/private/etc/"))
        PopupHead(info: FSEntityInfo("/private/etc/hosts"))
    }
    .padding(20)
    .frame(width: 300)
}
