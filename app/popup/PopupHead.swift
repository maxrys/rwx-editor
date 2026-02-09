
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PopupHead: View {

    @State private var visibilityModeForCreated: Date.VisibilityMode = .convenient
    @State private var visibilityModeForUpdated: Date.VisibilityMode = .convenient
    @State private var visibilityModeForSize: ByteCountFormatter.VisibilityMode = .bytes

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

    private var formattedCreated: String {
        switch self.visibilityModeForCreated {
            case .convenient   : self.info.created.convenient
            case .iso8601withTZ: self.info.created.ISO8601withTZ
            case .iso8601      : self.info.created.ISO8601
        }
    }

    private var formattedUpdated: String {
        switch self.visibilityModeForUpdated {
            case .convenient   : self.info.updated.convenient
            case .iso8601withTZ: self.info.updated.ISO8601withTZ
            case .iso8601      : self.info.updated.ISO8601
        }
    }

    private var formattedSize: String {
        switch self.visibilityModeForSize {
            case  .bytes: ByteCountFormatter.format(self.info.size, unit: .useBytes)
            case .kbytes: ByteCountFormatter.format(self.info.size, unit: .useKB)
            case .mbytes: ByteCountFormatter.format(self.info.size, unit: .useMB)
            case .gbytes: ByteCountFormatter.format(self.info.size, unit: .useGB)
            case .tbytes: ByteCountFormatter.format(self.info.size, unit: .useTB)
        }
    }

    private var formattedReferences: String {
        String(format: NSLocalizedString("%@ pcs.", comment: ""), String(self.info.references))
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

            self.title("Created")
            self.value(self.formattedCreated, isCanSelect: true)

            self.title("Updated")
            self.value(self.formattedUpdated, isCanSelect: true)

            self.title("Reference Count")
            self.value(self.formattedReferences)

            self.title("Size")
            self.value(self.formattedSize)

        }
    }

    @ViewBuilder func title(_ text: String) -> some View {
        Text(NSLocalizedString(text, comment: ""))
            .multilineTextAlignment(.trailing)
            .padding(.vertical, 6)
    }

    @ViewBuilder func value(_ text: String, isCanSelect: Bool = false) -> some View {
        Text(text)
            .textSelectionPolyfill(isEnabled: isCanSelect)
            .padding(.vertical, 6)
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
