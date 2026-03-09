
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    public var body: some View {
        VStack(spacing: 15) {
            ExtensionStatus()
            if #available(macOS 13.0, *) { launchAtLogin() }
            Bookmarks()
        }
        .padding(20)
        .frame(width: 600, height: 400)
        .environment(\.layoutDirection, .leftToRight)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    MainScene()
}
