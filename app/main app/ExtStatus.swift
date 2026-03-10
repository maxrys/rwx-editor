
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import FinderSync

struct ExtStatus: View {

    @State private var isEnabled: Bool = false

    public var body: some View {
        HStack(spacing: 20) {

            Image(systemName: self.isEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundPolyfill(
                    self.isEnabled ?
                        Color.status.ok :
                        Color.status.error
                )
                .background(Color.white)
                .clipShape(Circle())

            Text(
                self.isEnabled ?
                    NSLocalizedString("extension is enabled" , comment: "") :
                    NSLocalizedString("extension is disabled", comment: "")
            ).font(.system(size: 14, weight: .bold)).opacity(0.8)

            Spacer()

            ButtonCustom(
                NSLocalizedString("Open System Preference", comment: ""),
                colorStyle: .custom(text: nil, background: nil),
                isFlat: false,
                flexibility: .none
            ) { FinderSync.FIFinderSyncController.showExtensionManagementInterface() }

        }
        .onAppear              { self.isEnabled = FIFinderSyncController.isExtensionEnabled }
        .onAppBecomeForeground { self.isEnabled = FIFinderSyncController.isExtensionEnabled }
    }

}

#Preview {
    ExtStatus()
        .frame(width: 500)
        .padding(20)
}
