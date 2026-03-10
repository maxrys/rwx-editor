
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    static let FRAME_WIDTH : CGFloat = 600
    static let FRAME_HEIGHT: CGFloat = 400

    public var body: some View {
        VStack(spacing: 15) {
            ExtensionStatus()
            if #available(macOS 13.0, *) { launchAtLogin() }
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
