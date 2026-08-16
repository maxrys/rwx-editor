
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    static public let FRAME_WIDTH: CGFloat = 330

    public var body: some View {
        VStack(spacing: 30) {
            ExtSettings()
            Bookmarks()
        }
        .padding(20)
        .frame(minHeight: Self.FRAME_WIDTH)
        .environment(\.layoutDirection, .leftToRight)
        .windowChamelionBackground(
            windowID: ThisApp.WINDOW_MAIN_ID,
            backgroundTint: .white.opacity(0.8)
        )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct MainScene_Previews: PreviewProvider {
    static public var previews: some View {
        Previewer {
            MainScene()
                .frame(width: 470)
        }
    }
}
