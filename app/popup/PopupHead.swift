
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupHead: View {

    enum ColorNames: String {
        case head     = "color Popup Head Background"
        case gridTint = "color Popup Head Row Tint"
    }

    @State private var rollerForCreated: Date.VisibilityMode = .convenient
    @State private var rollerForUpdated: Date.VisibilityMode = .convenient
    @State private var rollerForSize: ByteCountFormatter.VisibilityMode = .useBytes

    private let info: FSEntityInfo

    init(_ info: FSEntityInfo) {
        self.info = info
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

    private var formattedName: String {
        self.info.name
    }

    private var formattedPath: String {
        self.info.path
    }

    private var formattedRealName: String {
        self.info.realName ?? ""
    }

    private var formattedRealPath: String {
        self.info.realPath ?? ""
    }

    private var formattedReferences: String {
        String(format: NSLocalizedString("%@ pcs.", comment: ""), String(self.info.references))
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

    private let columns = [
        GridItem(.fixed(100), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]

    public var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {

            self.TitleView(NSLocalizedString("Type", comment: ""), isTinted: true)
            self.ValueView(self.formattedType, isTinted: true)

            self.TitleView(NSLocalizedString("Name", comment: ""))
            self.ValueView(self.formattedName, isSelectable: true)

            self.TitleView(NSLocalizedString("Path", comment: ""), isTinted: true)
            self.ValueView(self.formattedPath, isTinted: true, isSelectable: true)

            if let realName = self.info.realName {
                self.TitleView(NSLocalizedString("Real Name", comment: ""))
                self.ValueView(realName, isSelectable: true)
            }

            if let realPath = self.info.realPath {
                self.TitleView(NSLocalizedString("Real Path", comment: ""), isTinted: true)
                self.ValueView(realPath, isTinted: true, isSelectable: true)
            }

            self.TitleView(NSLocalizedString("Reference Count", comment: ""))
            self.ValueView(self.formattedReferences)

            self.TitleView(NSLocalizedString("Created", comment: ""), isTinted: true, controls: AnyView(RollerStick(value: self.$rollerForCreated)))
            self.ValueView(self.formattedCreated, isTinted: true, isSelectable: true)

            self.TitleView(NSLocalizedString("Updated", comment: ""), controls: AnyView(RollerStick(value: self.$rollerForUpdated)))
            self.ValueView(self.formattedUpdated, isSelectable: true)

            self.TitleView(NSLocalizedString("Size", comment: ""), isTinted: true, controls: AnyView(RollerStick(value: self.$rollerForSize)))
            self.ValueView(self.formattedSize, isTinted: true, isSelectable: true)

        }
        .background(Color(Self.ColorNames.head.rawValue))
        .font(.system(size: 12, weight: .regular))
    }

    @ViewBuilder func TitleView(_ text: String, isTinted: Bool = false, controls: AnyView? = nil) -> some View {
        HStack(spacing: 4) {
            Text(text)
                .multilineTextAlignment(.trailing)
            if let controls {
                controls
            }
        }
        .padding(.horizontal, 7)
        .padding(.vertical  , 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .background(
            isTinted ?
                Color(Self.ColorNames.gridTint.rawValue) :
                Color.clear
        )
    }

    @ViewBuilder func ValueView(_ text: String, isTinted: Bool = false, isSelectable: Bool = false) -> some View {
        HStack(spacing: 0) {
            Text(text)
                .textSelectionPolyfill(isEnabled: isSelectable)
        }
        .padding(.horizontal, 7)
        .padding(.vertical  , 6)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
             isTinted ?
                 Color(Self.ColorNames.gridTint.rawValue) :
                 Color.clear
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
    VStack(spacing: 20) {
        PopupHead(FSEntityInfo("/private/etc/")!)      /* directory */
        PopupHead(FSEntityInfo("/private/etc/hosts")!) /* file */
    }
    .padding(20)
    .background(Color.black)
    .frame(width: 300)
}
