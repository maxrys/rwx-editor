
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

    var formattedSize: String {
        switch self.visibilityModeForSize {
            case  .bytes: ByteCountFormatter.format(self.info.size, unit: .useBytes)
            case .kbytes: ByteCountFormatter.format(self.info.size, unit: .useKB)
            case .mbytes: ByteCountFormatter.format(self.info.size, unit: .useMB)
            case .gbytes: ByteCountFormatter.format(self.info.size, unit: .useGB)
            case .tbytes: ByteCountFormatter.format(self.info.size, unit: .useTB)
        }
    }

    var formattedReferences: String {
        String(format: NSLocalizedString("%@ pcs.", comment: ""), String(self.info.references))
    }

    private let columns = [
        GridItem(.fixed(100), spacing: 10, alignment: .trailing),
        GridItem(.flexible(), spacing: 10, alignment: .leading)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {

            Text("Type")
            Text(self.formattedType)

            Text("Name")
            Text("\(self.formattedName)")

            Text("Path")
            Text("\(self.formattedPath)")

            Text("Created")
            Text("\(self.formattedCreated)")

            Text("Updated")
            Text("\(self.formattedUpdated)")

            Text("Reference Count").multilineTextAlignment(.trailing)
            Text("\(self.formattedReferences)")

            Text("Size")
            Text("\(self.formattedSize)")

        }
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
