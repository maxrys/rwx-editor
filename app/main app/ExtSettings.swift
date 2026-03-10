
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ExtSettings: View {

    @Environment(\.colorScheme) private var colorScheme

    public var body: some View {
        VStack(spacing: 0) {

            ExtStatus()
                .padding(15)

            if #available(macOS 13.0, *) {
                HStack(spacing: 0) {
                    ExtLaunchAtLogin()
                        .padding(15)
                }
                .frame(maxWidth: .infinity)
                .background(
                    self.colorScheme == .dark ?
                        Color.white.opacity(0.05) :
                        Color.black.opacity(0.05)
                )
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .background(self.GroupBackground())
    }

    @ViewBuilder func GroupBackground() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(
                self.colorScheme == .dark ?
                    Color.black :
                    Color.white
            )
            .shadow(
                color: self.colorScheme == .dark ?
                    .black.opacity(1.0) :
                    .black.opacity(0.4),
                radius: 2,
                y: 1
            )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    ExtSettings()
        .padding(20)
}
