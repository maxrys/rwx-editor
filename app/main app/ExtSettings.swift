
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
                        .padding(12)
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
            .fill(Color.form.group)
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

struct ExtSettings_Previews: PreviewProvider {
    static var previews: some View {
        ExtSettings()
            .padding(20)
            .frame(width: 350)
    }
}
