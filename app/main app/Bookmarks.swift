
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Bookmarks: View {

    @ObservedObject private var state = BookmarksState()
    @State private var selectedItems: Set<Int> = []

    init() {
        BookmarksModel.dump()
    }

    public var body: some View {
        VStack(spacing: 15) {

            Text(NSLocalizedString("Provided access to directories", comment: ""))
                .font(.system(size: 16, weight: .bold))
                .opacity(0.8)

            TableCustom(
                selected: self.$selectedItems,
                bodyCellPadding: .init(top: 6, leading: 8, bottom: 6, trailing: 8),
                head: {
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 1,
                        alignment: .leading
                    ) { Text(NSLocalizedString("Location paths", comment: "")).font(.system(size: 11)) }
                },
                bodyAsArray:
                    self.state.selectPaths().flatMap { path in [
                        AnyView(Text(path))
                    ]}
            )

            HStack(spacing: 10) {

                ButtonCustom(
                    NSLocalizedString("delete", comment: ""),
                    isDisabled: self.selectedItems.isEmpty,
                    colorStyle: .custom(text: nil, background: nil),
                    isFlat: false,
                    flexibility: .size(100)
                ) {
                    let existsPaths = self.state.selectPaths()
                    existsPaths.enumerated().forEach { index, path in
                        if (self.selectedItems.contains(index)) {
                            self.state.delete(path)
                        }
                    }
                    self.selectedItems.removeAll()
                }

                Spacer()

                ButtonCustom(
                    NSLocalizedString("add new directory...", comment: ""),
                    colorStyle: .accent,
                    isFlat: false,
                    flexibility: .size(200)
                ) { self.addBookmark() }

            }

        }
    }

    public func addBookmark() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.prompt = NSLocalizedString("select a directory to grant access", comment: "")

        guard openPanel.runModal() == .OK else {
            return
        }
        guard let url = openPanel.url else {
            return
        }

        let bookmarkData = try? url.bookmarkData(
            options: .withSecurityScope,
            includingResourceValuesForKeys: nil,
            relativeTo: nil
        )

        if let bookmarkData {
            let bookmark = Bookmark(from: bookmarkData)
            _ = bookmark.startAccessing()
            if let url = bookmark.info.url {
                self.state.insert(url.path, bookmarkData)
            }
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    Bookmarks()
        .frame(maxWidth: 400)
        .padding(20)
}
