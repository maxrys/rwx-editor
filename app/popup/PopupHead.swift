
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupHead: View {

    @State private var rollerForCreated: Date.VisibilityMode = .convenient
    @State private var rollerForUpdated: Date.VisibilityMode = .convenient
    @State private var rollerForSize: ByteCountFormatter.VisibilityMode = .bytes

    public let info: FSEntityInfo

    init(info: FSEntityInfo) {
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
            case  .bytes: ByteCountFormatter.format(self.info.size, unit: .useBytes)
            case .kbytes: ByteCountFormatter.format(self.info.size, unit: .useKB)
            case .mbytes: ByteCountFormatter.format(self.info.size, unit: .useMB)
            case .gbytes: ByteCountFormatter.format(self.info.size, unit: .useGB)
            case .tbytes: ByteCountFormatter.format(self.info.size, unit: .useTB)
        }
    }

    private let columns = [
        GridItem(.fixed(100), spacing: 10, alignment: .trailing),
        GridItem(.flexible(), spacing: 10, alignment: .leading)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {

            self.title("Type")
            self.value(self.formattedType)

            self.title("Name")
            self.value(self.formattedName, isCanSelect: true)

            self.title("Path")
            self.value(self.formattedPath, isCanSelect: true)

            if let realName = self.info.realName {
                self.title("Real Name")
                self.value(realName, isCanSelect: true)
            }

            if let realPath = self.info.realPath {
                self.title("Real Path")
                self.value(realPath, isCanSelect: true)
            }

            self.title("Reference Count")
            self.value(self.formattedReferences)

            self.title("Created", controls: AnyView(RollerStick(value: self.$rollerForCreated)))
            self.value(self.formattedCreated, isCanSelect: true)

            self.title("Updated", controls: AnyView(RollerStick(value: self.$rollerForUpdated)))
            self.value(self.formattedUpdated, isCanSelect: true)

            self.title("Size", controls: AnyView(RollerStick(value: self.$rollerForSize)))
            self.value(self.formattedSize)

        }
    }

    @ViewBuilder func title(_ text: String, controls: AnyView? = nil) -> some View {
        HStack(spacing: 10) {
            Text(NSLocalizedString(text, comment: ""))
                .multilineTextAlignment(.trailing)
                .padding(.vertical, 6)
            if let controls {
                controls
            }
        }
    }

    @ViewBuilder func value(_ text: String, isCanSelect: Bool = false) -> some View {
        Text(text)
            .textSelectionPolyfill(isEnabled: isCanSelect)
            .padding(.vertical, 6)
    }

}

struct RollerStick<T: CaseIterable & Equatable>: View {

    var value: Binding<T>

    var body: some View {
        Button {
            value.wrappedValue.roll()
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
        PopupHead(info: FSEntityInfo("/private/etc/")!)      /* directory */
        PopupHead(info: FSEntityInfo("/private/etc/hosts")!) /* file */
    }
    .padding(20)
    .frame(width: 300)
}
