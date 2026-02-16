
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupFoot: View {

    enum ColorNames: String {
        case foot = "color Popup Foot Background"
    }

    private let messageBox: MessageBox

    init(messageBox: MessageBox) {
        self.messageBox = messageBox
    }

    public var body: some View {
        HStack(spacing: 10) {

            Button("test 1") {
                self.messageBox.insert(
                    type: .error,
                    title: NSLocalizedString("Error Message", comment: ""),
                    description: "description"
                )
            }

            Button("test 2") {
                self.messageBox.insert(
                    type: .ok,
                    title: NSLocalizedString("Ok Message", comment: ""),
                    description: "description"
                )
            }

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color(Self.ColorNames.foot.rawValue))
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    PopupFoot(messageBox: MessageBox())
}
