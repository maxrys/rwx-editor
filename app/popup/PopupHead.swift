
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

    private var formattedName: String { self.info.name.percentDecode }
    private var formattedPath: String { self.info.path.percentDecode }
    private var formattedRealName: String { if let name = self.info.realName { return name.percentDecode } else { return "" } }
    private var formattedRealPath: String { if let path = self.info.realPath { return path.percentDecode } else { return "" } }

    private var formattedReferences: String {
        String(format: NSLocalizedString("%@ pcs.", comment: ""), String(self.info.references))
    }

    private var formattedType: String {
        switch self.info.type {
            case .directory: return NSLocalizedString("directory", comment: "")
            case .file     : return NSLocalizedString("file"     , comment: "")
            case .alias    : return NSLocalizedString("alias"    , comment: "")
            case .link     : return NSLocalizedString("link"     , comment: "")
            case .other    : return ""
        }
    }

    private var formattedCreated: String {
        switch self.rollerForCreated {
            case .convenient   : return self.info.created.convenient
            case .iso8601withTZ: return self.info.created.ISO8601withTZ
            case .iso8601      : return self.info.created.ISO8601
        }
    }

    private var formattedUpdated: String {
        switch self.rollerForUpdated {
            case .convenient   : return self.info.updated.convenient
            case .iso8601withTZ: return self.info.updated.ISO8601withTZ
            case .iso8601      : return self.info.updated.ISO8601
        }
    }

    private var formattedSize: String {
        if let size = self.info.size {
            switch self.rollerForSize {
                case .useBytes: return ByteCountFormatter.format(size, unit: .useBytes)
                case .useKB   : return ByteCountFormatter.format(size, unit: .useKB)
                case .useMB   : return ByteCountFormatter.format(size, unit: .useMB)
                case .useGB   : return ByteCountFormatter.format(size, unit: .useGB)
                case .useTB   : return ByteCountFormatter.format(size, unit: .useTB)
            }
        } else {
            return ""
        }
    }

    public var body: some View {
        TableCustom(
            selected: Binding.constant([]),
            isVisibleHeader: false,
            isFocusable: false,
            isScrollable: false,
            bodyCellPadding: .init(top: 6, leading: 8, bottom: 6, trailing: 8),
            head: {
                TableCustom_HeadCell(
                    size: .fixed(140),
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

                if self.info.size != nil {
                    result.append(self.TitleView(NSLocalizedString("Size", comment: ""), controls: AnyView(RollerStick(value: self.$rollerForSize))))
                    result.append(self.ValueView(self.formattedSize, isSelectable: true))
                }

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
            Image("arcade.stick")
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

struct PopupHead_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            let Delimiter = Rectangle().fill(Color.black).frame(height: 20)
            PopupHead().environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/"     ))!)); Delimiter /* directory */
            PopupHead().environmentObject(PopupState(FSEntityInfo(URL(fileURLWithPath: "/private/etc/hosts"))!))            /* file */
        }.frame(width: Popup.FRAME_WIDTH)
    }
}
