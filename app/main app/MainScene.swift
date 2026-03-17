
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct MainScene: View {

    public var body: some View {
        VStack(spacing: 30) {
            ExtSettings()
            Bookmarks()
        }
        .padding(20)
        .frame(minHeight: 350)
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
