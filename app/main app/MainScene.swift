
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    public var body: some View {
        VStack {
            Text("Settings")
                .padding(20)

            Button("test popup") {
                appDelegate.showWindowPopup(fullpath: "/private/etc/")
            }.padding(20)
        }
        .frame(width: 400, height: 200)
        .environment(\.layoutDirection, .leftToRight)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    MainScene()
}
