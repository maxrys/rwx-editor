
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import OpenDirectory

struct PopupBody: View {

    static let TABLE_1ST_CELL_WIDTH: CGFloat = (272 / 2)
    static let TABLE_2ND_CELL_WIDTH: CGFloat = (110 / 2) * 3
    static let BLOCKS_SPACING: CGFloat = 40

    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var popupState: PopupState

    private var permsBinding: Binding<PermissionsValue> { self.popupState.getBinding(\.perms) }
    private var ownerBinding: Binding<String>           { self.popupState.getBinding(\.owner) }
    private var groupBinding: Binding<String>           { self.popupState.getBinding(\.group) }

    @State private var owners: [String: String] = [:]
    @State private var groups: [String: String] = [:]

    private let columnsForToggleRwxColored = [
        GridItem(.fixed(Self.TABLE_1ST_CELL_WIDTH - 5), spacing: 5, alignment: .trailing),
        GridItem(.fixed(Self.TABLE_2ND_CELL_WIDTH / 3), spacing: 0, alignment: .center),
        GridItem(.fixed(Self.TABLE_2ND_CELL_WIDTH / 3), spacing: 0, alignment: .center),
        GridItem(.fixed(Self.TABLE_2ND_CELL_WIDTH / 3), spacing: 0, alignment: .center),
    ]

    private let columnsForToggleRwxNumeric = [
        GridItem(.fixed(Self.TABLE_1ST_CELL_WIDTH - 5), spacing: 5, alignment: .trailing),
        GridItem(.fixed(Self.TABLE_2ND_CELL_WIDTH    ), spacing: 0, alignment: .center),
    ]

    private let columnsForPickerCustom = [
        GridItem(.fixed(Self.TABLE_1ST_CELL_WIDTH - 5), spacing: 5, alignment: .trailing),
        GridItem(.fixed(Self.TABLE_2ND_CELL_WIDTH    ), spacing: 0, alignment: .center),
    ]

    public var body: some View {
        VStack(alignment: .leading, spacing: Self.BLOCKS_SPACING) {

            /* MARK: rules via toggles */

            LazyVGrid(columns: self.columnsForToggleRwxColored, spacing: 15) {

                Color.clear
                Text(NSLocalizedString("Owner", comment: "")).lineLimit(1)
                Text(NSLocalizedString("Group", comment: "")).lineLimit(1)
                Text(NSLocalizedString("Other", comment: "")).lineLimit(1)

                Text(NSLocalizedString("Read", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .r, self.permsBinding).disabled(!self.popupState.isEditable)
                ToggleRwxColored(subject: .group, permission: .r, self.permsBinding).disabled(!self.popupState.isEditable)
                ToggleRwxColored(subject: .other, permission: .r, self.permsBinding).disabled(!self.popupState.isEditable)

                Text(NSLocalizedString("Write", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .w, self.permsBinding).disabled(!self.popupState.isEditable)
                ToggleRwxColored(subject: .group, permission: .w, self.permsBinding).disabled(!self.popupState.isEditable)
                ToggleRwxColored(subject: .other, permission: .w, self.permsBinding).disabled(!self.popupState.isEditable)

                Text(self.popupState.info.type == .file ? NSLocalizedString("Execute", comment: "") : NSLocalizedString("Access", comment: ""))
                ToggleRwxColored(subject: .owner, permission: .x, self.permsBinding).disabled(!self.popupState.isEditable)
                ToggleRwxColored(subject: .group, permission: .x, self.permsBinding).disabled(!self.popupState.isEditable)
                ToggleRwxColored(subject: .other, permission: .x, self.permsBinding).disabled(!self.popupState.isEditable)

            }.frame(width: Self.TABLE_1ST_CELL_WIDTH + Self.TABLE_2ND_CELL_WIDTH)

            /* MARK: rules via text/numeric */

            LazyVGrid(columns: self.columnsForToggleRwxNumeric, spacing: 0) {
                PanelRwxText    (self.permsBinding).offset(x: 10)
                ToggleRwxNumeric(self.permsBinding).disabled(!self.popupState.isEditable)
            }.frame(width: Self.TABLE_1ST_CELL_WIDTH + Self.TABLE_2ND_CELL_WIDTH)

            /* MARK: owner picker + group picker */

            LazyVGrid(columns: self.columnsForPickerCustom, spacing: 10) {

                Text(NSLocalizedString("Owner", comment: ""))

                PickerCustom<String>(
                    selected: self.ownerBinding,
                    items: self.owners,
                    isPlainListStyle: true,
                    flexibility: .size(272 / 2)
                ).disabled(true) /* !self.popupState.isEditable */

                Text(NSLocalizedString("Group", comment: ""))

                PickerCustom<String>(
                    selected: self.groupBinding,
                    items: self.groups,
                    isPlainListStyle: true,
                    flexibility: .size(272 / 2)
                ).disabled(true) /* !self.popupState.isEditable */

            }.frame(width: Self.TABLE_1ST_CELL_WIDTH + Self.TABLE_2ND_CELL_WIDTH)

        }
        .padding(.vertical, Self.BLOCKS_SPACING)
        .overlayPolyfill(alignment: .topLeading   , content: { self.ShadowTopView() })
        .overlayPolyfill(alignment: .bottomLeading, content: { self.ShadowBottomView() })
        .onAppear {
            self.ownersReload()
            self.groupsReload()
        }
    }

    private func ownersReload() {
        DispatchQueue.global(qos: .utility).async {
            let newItems = ODQuery.users().reduce(into: [String: String](), { result, value in
                result[value.name] = value.name
            })
            DispatchQueue.main.async {
                self.owners = newItems
            }
        }
    }

    private func groupsReload() {
        DispatchQueue.global(qos: .utility).async {
            let newItems = ODQuery.groups().reduce(into: [String: String](), { result, value in
                result[value.name] = value.name
            })
            DispatchQueue.main.async {
                self.groups = newItems
            }
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
        VStack(alignment: .leading, spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            PopupBody().environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/"     ))!)); Delimiter /* directory */
            PopupBody().environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/hosts"))!))            /* file */
        }
        .frame(width: MainScene.FRAME_WIDTH)
        .windowChamelionBackground(
            backgroundTint: .white.opacity(0.9)
        )
    }
}
