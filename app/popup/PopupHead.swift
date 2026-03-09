
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupHead: View {

    @EnvironmentObject private var popupState: PopupState

    @State private var rollerForCreated: Date.VisibilityMode = .convenient
    @State private var rollerForUpdated: Date.VisibilityMode = .convenient
    @State private var rollerForSize: ByteCountFormatter.VisibilityMode = .useBytes

    private var info: FSEntityInfo {
        self.popupState.info
    }

    private var formattedName: String { self.info.name }
    private var formattedPath: String { self.info.path }
    private var formattedRealName: String { self.info.realName ?? "" }
    private var formattedRealPath: String { self.info.realPath ?? "" }

    private var formattedReferences: String {
        String(format: NSLocalizedString("%@ pcs.", comment: ""), String(self.info.references))
    }

    private var formattedType: String {
        switch self.info.type {
            case .directory: NSLocalizedString("directory", comment: "")
            case .file     : NSLocalizedString("file"     , comment: "")
            case .alias    : NSLocalizedString("alias"    , comment: "")
            case .link     : NSLocalizedString("link"     , comment: "")
            case .other    : ""
        }
    }

    private var formattedCreated: String {
        switch self.rollerForCreated {
            case .convenient   : self.info.created.convenient
            case .iso8601withTZ: self.info.created.ISO8601withTZ
            case .iso8601      : self.info.created.ISO8601
        }
    }

    private var formattedUpdated: String {
        switch self.rollerForUpdated {
            case .convenient   : self.info.updated.convenient
            case .iso8601withTZ: self.info.updated.ISO8601withTZ
            case .iso8601      : self.info.updated.ISO8601
        }
    }

    private var formattedSize: String {
        switch self.rollerForSize {
            case .useBytes: ByteCountFormatter.format(self.info.size, unit: .useBytes)
            case .useKB   : ByteCountFormatter.format(self.info.size, unit: .useKB)
            case .useMB   : ByteCountFormatter.format(self.info.size, unit: .useMB)
            case .useGB   : ByteCountFormatter.format(self.info.size, unit: .useGB)
            case .useTB   : ByteCountFormatter.format(self.info.size, unit: .useTB)
        }
    }

    public var body: some View {
        TableCustom(
            selected: Binding.constant([]),
            isVisibleHeader: false,
            isFocusable: false,
            isScrollable: false,
            head: {
                TableCustom_HeadCell(
                    size: .fixed(100),
                    spacing: 2,
                    alignment: .trailing
                ) { EmptyView() }
                TableCustom_HeadCell(
                    size: .flexible(),
                    spacing: 2,
                    alignment: .leading
                ) { EmptyView() }
            },
            bodyAsArray: {
                var result:[AnyView] = []

                result.append(self.TitleView(NSLocalizedString("Type", comment: "")))
                result.append(self.ValueView(self.formattedType))
                result.append(self.TitleView(NSLocalizedString("Name", comment: "")))
                result.append(self.ValueView(self.formattedName, isSelectable: true))
                result.append(self.TitleView(NSLocalizedString("Path", comment: "")))
                result.append(self.ValueView(self.formattedPath, isSelectable: true))

                if let realName = self.info.realName,
                   let realPath = self.info.realPath {

                    result.append(self.TitleView(NSLocalizedString("Real Name", comment: "")))
                    result.append(self.ValueView(realName, isSelectable: true))
                    result.append(self.TitleView(NSLocalizedString("Real Path", comment: "")))
                    result.append(self.ValueView(realPath, isSelectable: true))
                }

                result.append(self.TitleView(NSLocalizedString("Reference Count", comment: "")))
                result.append(self.ValueView(self.formattedReferences))
                result.append(self.TitleView(NSLocalizedString("Created", comment: ""), controls: AnyView(RollerStick(value: self.$rollerForCreated))))
                result.append(self.ValueView(self.formattedCreated, isSelectable: true))
                result.append(self.TitleView(NSLocalizedString("Updated", comment: ""), controls: AnyView(RollerStick(value: self.$rollerForUpdated))))
                result.append(self.ValueView(self.formattedUpdated, isSelectable: true))
                result.append(self.TitleView(NSLocalizedString("Size", comment: ""), controls: AnyView(RollerStick(value: self.$rollerForSize))))
                result.append(self.ValueView(self.formattedSize, isSelectable: true))

                return result
            }()
        ).font(.system(size: 12, weight: .regular))
    }

    private func TitleView(_ text: String, controls: AnyView? = nil) -> AnyView {
        AnyView(
            HStack(spacing: 4) {
                Text(text)
                    .multilineTextAlignment(.trailing)
                if let controls {
                    controls
                }
            }
        )
    }

    private func ValueView(_ text: String, isSelectable: Bool = false) -> AnyView {
        AnyView(
            Text(text).textSelectionPolyfill(isEnabled: isSelectable)
        )
    }

}

struct RollerStick<T: CaseIterable & Equatable>: View {

    @Binding private var value: T

    init(value: Binding<T>) {
        self._value = value
    }

    public var body: some View {
        Button {
            value.roll()
        } label: {
            Image(systemName: "arcade.stick")
                .foregroundPolyfill(Color.accentColor)
                .font(.system(size: 10, weight: .regular))
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    VStack(spacing: 10) {
        PopupHead().environmentObject(PopupState(FSEntityInfo("/private/etc/")!))      /* directory */
        PopupHead().environmentObject(PopupState(FSEntityInfo("/private/etc/hosts")!)) /* file */
    }
    .padding(10)
    .background(Color.black)
    .frame(width: 300)
}
