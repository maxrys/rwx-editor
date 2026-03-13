
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
                self.NotSupportedView()
            }
        }
        .environment(\.layoutDirection, .leftToRight)
        .frame(width: Self.FRAME_WIDTH)
        .onAppear              { self.infoRefresh() }
        .onAppBecomeForeground { self.infoRefresh() }
    }

    @ViewBuilder func NotSupportedView() -> some View {
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



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 0) {
        let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
        Popup(fullpath: "/unknown")     ; Delimiter
        Popup(fullpath: "/private/etc/"); Delimiter /* directory */
        Popup(fullpath: "/private/etc/hosts")       /* file */
    }.frame(width: 300)
}
