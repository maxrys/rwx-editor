
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import FinderSync

struct ExtStatus: View {

    @State private var isEnabled: Bool = false

    public var body: some View {
        Button {
            FinderSync.FIFinderSyncController.showExtensionManagementInterface()
        } label: {
            HStack(spacing: 10) {
                self.CheckmarkView()
                self.StatusView()
            }
            .padding(7)
            .padding(.trailing, 7)
            .foregroundPolyfill(Color.white)
            .background(
                self.isEnabled ?
                    Color.status.ok :
                    Color.status.error
            )
            .clipShape(Capsule())
            .focusEffect(Capsule())
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
        .onAppear              {           if (            true           ) { self.isEnabled = FIFinderSyncController.isExtensionEnabled } }
        .onWinBecomeForeground { window in if (window.ID == WINDOW_MAIN_ID) { self.isEnabled = FIFinderSyncController.isExtensionEnabled } }
    }

    @ViewBuilder private func CheckmarkView() -> some View {
        Color.white
            .opacity(0.2)
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            .overlayPolyfill {
                Image(systemName: self.isEnabled ? "checkmark" : "xmark")
                    .font(.system(size: 16))
            }
    }

    @ViewBuilder private func StatusView() -> some View {
        Text(self.isEnabled ?
            NSLocalizedString("extension is enabled" , comment: "") :
            NSLocalizedString("extension is disabled", comment: "")
        ).font(.system(size: 13))
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct ExtStatus_Previews: PreviewProvider {
    static public var previews: some View {
        ExtStatus().padding(20)
    }
}
