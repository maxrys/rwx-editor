
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import FinderSync

struct ExtensionStatus: View {

    @Environment(\.colorScheme) private var colorScheme
    @State private var isEnabled: Bool = false

    public var body: some View {
        VStack(spacing: 15) {

            Image(systemName: self.isEnabled ? "checkmark.circle.fill" : "xmark.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
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
            ).font(.system(size: 16, weight: .bold))

            ButtonCustom(
                NSLocalizedString("Open System Preference", comment: ""),
                colorStyle: .custom(text: nil, background: nil),
                isFlat: false,
                flexibility: .none
            ) { FinderSync.FIFinderSyncController.showExtensionManagementInterface() }

        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(self.GroupBackground())
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(20)
        .onAppear              { self.isEnabled = FIFinderSyncController.isExtensionEnabled }
        .onAppBecomeForeground { self.isEnabled = FIFinderSyncController.isExtensionEnabled }
    }

    @ViewBuilder func GroupBackground() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .stroke(
                self.colorScheme == .dark ?
                    Color.white.opacity(0.5) :
                    Color.black.opacity(0.5),
                lineWidth: 1
            )
            .background(
                self.colorScheme == .dark ?
                    Color.black.opacity(0.2) :
                    Color.white.opacity(0.7)
            )
    }

}

#Preview {
    ExtensionStatus()
        .frame(width: 400)
}
