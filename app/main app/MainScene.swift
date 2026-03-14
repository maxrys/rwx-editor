
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import System

struct MainScene: View {

    static let FRAME_WIDTH : CGFloat = 600
    static let FRAME_HEIGHT: CGFloat = 500

    public var body: some View {
        VStack(spacing: 30) {
            ExtSettings()
            Bookmarks()
        }
        .padding(20)
        .frame(width: Self.FRAME_WIDTH, height: Self.FRAME_HEIGHT)
        .environment(\.layoutDirection, .leftToRight)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    MainScene()
}
