
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Bookmarks: View {

    @ObservedObject private var bookmarksState = BookmarksState()

    public var body: some View {
        VStack(spacing: 15) {

            Text(NSLocalizedString("Provided access to directories", comment: ""))
                .font(.system(size: 16, weight: .bold))
                .opacity(0.8)

            TableCustom(
                selected: self.bookmarksState.getBinding(\.selectedRows),
                bodyCellPadding: .init(top: 6, leading: 8, bottom: 6, trailing: 8),
                head: {
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 1,
                        alignment: .leading
                    ) { Text(NSLocalizedString("Location paths", comment: "")).font(.system(size: 11)) }
                },
                bodyAsArray:
                    self.bookmarksState.items.flatMap { item in [
                        AnyView(Text(item.path))
                    ]}
            )

            HStack(spacing: 10) {

                ButtonCustom(
                    NSLocalizedString("delete", comment: ""),
                    isDisabled: self.bookmarksState.selectedRows.isEmpty,
                    colorStyle: .custom(text: nil, background: nil),
                    isFlat: false,
                    flexibility: .size(100)
                ) { self.onDeleteBookmark() }

                Spacer()

                ButtonCustom(
                    NSLocalizedString("add new directory...", comment: ""),
                    colorStyle: .accent,
                    isFlat: false,
                    flexibility: .size(200)
                ) { self.onAddBookmark() }

            }

        }
        .onAppear {
            BookmarksModel.dump()
        }
        .onAppBecomeForeground {
            self.bookmarksState.reload()
        }
    }

    public func onDeleteBookmark() {
        self.bookmarksState.delete(
            self.bookmarksState.selectedRowsToPaths
        )
    }

    public func onAddBookmark() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = false
        openPanel.prompt = NSLocalizedString(
            "select a directory to grant access", comment: ""
        )

        guard openPanel.runModal() == .OK else {
            return
        }

        _ = self.bookmarksState.insert(
            items: openPanel.urls.reduce(into: [(path: String, data: Data)]()) { result, url in
                if let bookmark = BookmarkValue(from: url) {
                    if bookmark.startAccessing() {
                        result.append((path: url.path, bookmark.data))
                        bookmark.stopAccessing()
                    }
                }
            }
        )
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
