
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    public var body: some View {
        VStack(spacing: 20) {
            ExtensionStatus()
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
