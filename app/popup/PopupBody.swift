
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupBody: View {

    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popupState: PopupState

    private var permsBinding: Binding<PermissionsValue> { self.popupState.getBinding(\.perms) }
    private var ownerBinding: Binding<String>           { self.popupState.getBinding(\.owner) }
    private var groupBinding: Binding<String>           { self.popupState.getBinding(\.group) }

    @State private var owners: [String: String] = [:]
    @State private var groups: [String: String] = [:]

    private let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]

    public var body: some View {
        VStack(spacing: 40) {

            /* MARK: rules via toggles */

            LazyVGrid(columns: columns, spacing: 15) {

                Color.clear
                Text(NSLocalizedString("Owner", comment: ""))
                Text(NSLocalizedString("Group", comment: ""))
                Text(NSLocalizedString("Other", comment: ""))

                Text(NSLocalizedString("Read", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .r, self.permsBinding, isDisabled: !self.popupState.isEditable)
                ToggleRwxColored(subject: .group, permission: .r, self.permsBinding, isDisabled: !self.popupState.isEditable)
                ToggleRwxColored(subject: .other, permission: .r, self.permsBinding, isDisabled: !self.popupState.isEditable)

                Text(NSLocalizedString("Write", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .w, self.permsBinding, isDisabled: !self.popupState.isEditable)
                ToggleRwxColored(subject: .group, permission: .w, self.permsBinding, isDisabled: !self.popupState.isEditable)
                ToggleRwxColored(subject: .other, permission: .w, self.permsBinding, isDisabled: !self.popupState.isEditable)

                Text(self.popupState.info.type == .file ? NSLocalizedString("Execute", comment: "") : NSLocalizedString("Access", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .x, self.permsBinding, isDisabled: !self.popupState.isEditable)
                ToggleRwxColored(subject: .group, permission: .x, self.permsBinding, isDisabled: !self.popupState.isEditable)
                ToggleRwxColored(subject: .other, permission: .x, self.permsBinding, isDisabled: !self.popupState.isEditable)

            }.padding(.horizontal, 20)

            /* MARK: rules via text/numeric */

            HStack(spacing: 20) {
                PanelRwxText(self.permsBinding)
                ToggleRwxNumeric(
                    self.permsBinding,
                    isDisabled: !self.popupState.isEditable
                )
            }

            /* MARK: owner picker + group picker */

            VStack(alignment: .trailing, spacing: 10) {

                HStack(spacing: 10) {
                    Text(NSLocalizedString("Owner", comment: ""))
                    PickerCustom<String>(
                        selected: self.ownerBinding,
                        items: self.owners,
                        isPlainListStyle: true,
                        isDisabled: true /* !self.popupState.isEditable */,
                        flexibility: .size(150)
                    )
                }

                HStack(spacing: 10) {
                    Text(NSLocalizedString("Group", comment: ""))
                    PickerCustom<String>(
                        selected: self.groupBinding,
                        items: self.groups,
                        isPlainListStyle: true,
                        isDisabled: true /* !self.popupState.isEditable */,
                        flexibility: .size(150)
                    )
                }

            }

        }
        .padding(.vertical, 35)
        .overlayPolyfill(alignment: .top   , content: { self.ShadowTopView() })
        .overlayPolyfill(alignment: .bottom, content: { self.ShadowBottomView() })
        .onAppear {
            self.ownersReload()
            self.groupsReload()
        }
    }

    private func ownersReload() {
        self.owners.removeAll()
        Process.systemUsers()
            .filter({ $0.first != "_" })
            .forEach { value in
                self.owners[value] = value
            }
    }

    private func groupsReload() {
        self.groups.removeAll()
        Process.systemGroups()
            .filter({ $0.first != "_" })
            .forEach { value in
                self.groups[value] = value
            }
    }

    @ViewBuilder private func ShadowTopView() -> some View {
        Rectangle()
            .fill(
                LinearGradient(
                    colors: [
                        self.colorScheme == .dark ?
                            Color.black.opacity(0.20) :
                            Color.black.opacity(0.15),
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
                        self.colorScheme == .dark ?
                            Color.black.opacity(0.20) :
                            Color.black.opacity(0.15) ],
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

struct PopupBody_Previews: PreviewProvider {
    static public var previews: some View {
        VStack(spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            PopupBody().environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/"     ))!)); Delimiter /* directory */
            PopupBody().environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/hosts"))!))            /* file */
        }.frame(width: Popup.FRAME_WIDTH)
    }
}
