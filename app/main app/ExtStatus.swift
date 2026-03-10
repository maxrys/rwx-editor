
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import FinderSync

struct ExtStatus: View {

    @State private var isEnabled: Bool
    private let isDemo: Bool

    init(isEnabled: Bool = false, isDemo: Bool = false) {
        self.isEnabled = isEnabled
        self.isDemo = isDemo
    }

    public var body: some View {
        HStack(spacing: 10) {
            Color.white
                .opacity(0.2)
                .frame(width: 30, height: 30)
                .clipShape(Circle())
                .overlayPolyfill {
                    Image(systemName: self.isEnabled ? "checkmark" : "xmark")
                        .font(.system(size: 16))
                }
            Text(self.isEnabled ?
                NSLocalizedString("extension is enabled" , comment: "") :
                NSLocalizedString("extension is disabled", comment: "")
            ).font(.system(size: 13))
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
        .pointerStyleLinkPolyfill()
        .onTapGesture {
            FinderSync.FIFinderSyncController.showExtensionManagementInterface()
        }
        .onAppear              { if (!self.isDemo) { self.isEnabled = FIFinderSyncController.isExtensionEnabled } }
        .onAppBecomeForeground { if (!self.isDemo) { self.isEnabled = FIFinderSyncController.isExtensionEnabled } }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        ExtStatus(                 isDemo: true)
        ExtStatus(isEnabled: true, isDemo: true)
    }
    .frame(width: 300)
    .padding(20)
}
