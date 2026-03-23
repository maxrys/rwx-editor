
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    static public let FRAME_WIDTH: CGFloat = 350

    public var body: some View {
        VStack(spacing: 30) {
            ExtSettings()
            Bookmarks()
        }
        .padding(20)
        .frame(minHeight: Self.FRAME_WIDTH)
        .environment(\.layoutDirection, .leftToRight)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct MainScene_Previews: PreviewProvider {
    static var previews: some View {
        MainScene()
            .frame(width: 470)
    }
}
