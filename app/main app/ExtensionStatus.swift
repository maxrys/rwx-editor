
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import FinderSync

struct ExtensionStatus: View {

    @State private var isEnabled: Bool = false

    public var body: some View {
        VStack(spacing: 10) {

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

        }
        .onAppear {
            self.isEnabled = FIFinderSyncController.isExtensionEnabled
        }
    }

}

#Preview {
    ExtensionStatus()
        .padding(20)
        .frame(width: 300)
}
