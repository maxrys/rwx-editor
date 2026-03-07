
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import os
import SwiftUI

struct Popup: View {

    static let FRAME_WIDTH: CGFloat = 300

    @State private var info: FSEntityInfo?

    private let fullpath: String

    init(fullpath: String) {
        Logger.customLog("Popup init with fullpath = \(fullpath)")
        self.fullpath = fullpath
    }

    func infoRefresh() {
        let newInfo = FSEntityInfo(self.fullpath)
        if (newInfo != self.info) {
            Logger.customLog("Popup infoRefresh")
            self.info = newInfo
        }
    }

    public var body: some View {
        VStack(spacing: 0) {
            if let info = self.info {
                PopupScene(info)
            } else {
                let messageBox = MessageBox()
                messageBox
                    .frame(maxWidth: 300)
                    .onAppear {
                        messageBox.insert(
                            type: .error,
                            title: NSLocalizedString("Object is not suppoted", comment: ""),
                            description: self.fullpath,
                            lifeTime: .infinity
                        )
                    }
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: Self.FRAME_WIDTH)
        .onAppear              { self.infoRefresh() }
        .onAppBecomeForeground { self.infoRefresh() }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        Popup(fullpath: "")                   /* empty */
        Popup(fullpath: "/private/etc/")      /* directory */
        Popup(fullpath: "/private/etc/hosts") /* file */
    }
    .padding(10)
    .background(Color.black)
}
