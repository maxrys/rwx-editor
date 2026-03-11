
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
                    self.state.delete(self.state.selectPaths().enumerated().compactMap { index, path in
                        self.selectedItems.contains(index) ? path : nil
                    })
                }

                Spacer()

                ButtonCustom(
                    NSLocalizedString("add new directory...", comment: ""),
                    colorStyle: .accent,
                    isFlat: false,
                    flexibility: .size(200)
                ) { self.addBookmark() }

            }

        }.onChange(of: self.state.data) { _ in
            self.selectedItems.removeAll()
        }
    }

    public func addBookmark() {
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

        for url in openPanel.urls {
            if let bookmark = Bookmark(from: url) {
                if bookmark.startAccessing() {
                    self.state.insert(url.path, bookmark.data)
                }
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
