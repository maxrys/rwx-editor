
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupHead: View {

    public let info: FSEntityInfo

    var body: some View {
        VStack(spacing: 0) {
            Text("Full Path: \(self.info.fullpath)")
            Text("Type: \(self.info.type)")
            Text("Path: \(self.info.path)")
            Text("Name: \(self.info.name)")
            Text("Created: \(self.info.created)")
            Text("Updated: \(self.info.updated)")
            Text("Reference Count: \(self.info.references)")
            Text("Rights: \(self.info.rights)")
            Text("Owner: \(self.info.owner)")
            Text("Group: \(self.info.group)")
            Text("Size: \(self.info.size)")
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 20) {
        PopupHead(info: FSEntityInfo("/private/etc/")!)      /* directory */
        PopupHead(info: FSEntityInfo("/private/etc/hosts")!) /* file */
    }
    .padding(20)
    .frame(width: 300)
}
