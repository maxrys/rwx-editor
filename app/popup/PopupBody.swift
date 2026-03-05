
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupBody: View {

    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popupState: PopupState

    private var permsBinding: Binding<RightsValue> {
        self.popupState.getBinding(\.perms)
    }

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]

    public var body: some View {
        VStack(spacing: 20) {

            self.ShadowTopView()

            /* MARK: rules via toggles */

            LazyVGrid(columns: columns, spacing: 15) {

                Color.clear
                Text(NSLocalizedString("Owner", comment: ""))
                Text(NSLocalizedString("Group", comment: ""))
                Text(NSLocalizedString("Other", comment: ""))

                Text(NSLocalizedString("Read", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .r, self.permsBinding)
                ToggleRwxColored(subject: .group, permission: .r, self.permsBinding)
                ToggleRwxColored(subject: .other, permission: .r, self.permsBinding)

                Text(NSLocalizedString("Write", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .w, self.permsBinding)
                ToggleRwxColored(subject: .group, permission: .w, self.permsBinding)
                ToggleRwxColored(subject: .other, permission: .w, self.permsBinding)

                Text(self.popupState.info.type == .file ? NSLocalizedString("Execute", comment: "") : NSLocalizedString("Access", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .x, self.permsBinding)
                ToggleRwxColored(subject: .group, permission: .x, self.permsBinding)
                ToggleRwxColored(subject: .other, permission: .x, self.permsBinding)

            }.padding(.horizontal, 20)

            /* MARK: rules via text/numeric */

            HStack(spacing: 20) {
                PanelRwxText(self.permsBinding)
                ToggleRwxNumeric(self.permsBinding)
            }

            self.ShadowBottomView()

        }
        .frame(maxWidth: .infinity)
        .background(Color.popup.body)
    }

    @ViewBuilder private func ShadowTopView() -> some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.black.opacity(self.colorScheme == .light ? 0.1 : 0.4),
                        Color.clear ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            ).frame(height: 6)
    }

    @ViewBuilder private func ShadowBottomView() -> some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        Color.clear,
                        Color.black.opacity(self.colorScheme == .light ? 0.1 : 0.4) ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(height: 6)
            .padding(.top, 6)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        PopupBody().environmentObject(PopupState(fullpath: "/private/etc/")!)      /* directory */
        PopupBody().environmentObject(PopupState(fullpath: "/private/etc/hosts")!) /* file */
    }
    .padding(10)
    .background(Color.black)
    .frame(width: 310)
}
