
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct Bookmarks: View {

    @State private var selectedItems: Set<Int> = []

    init() {
        BookmarksModel.dump()
    }

    public var body: some View {
        TableCustom(
            selected: self.$selectedItems,
            head: {
                TableCustom_HeadCell(
                    size: .flexible(),
                    spacing: 1,
                    alignment: .leading
                ) { Text(NSLocalizedString("Permitted path", comment: "")).font(.system(size: 11)) }
                TableCustom_HeadCell(
                    size: .fixed(30),
                    spacing: 1
                ) { EmptyView() }
            },
            bodyAsArray: [
                AnyView(Text("/path/to/file/or/dirrectory")), AnyView(Image(systemName: "xmark.circle")),
                AnyView(Text("/path/to/file/or/dirrectory")), AnyView(Image(systemName: "xmark.circle")),
                AnyView(Text("/path/to/file/or/dirrectory")), AnyView(Image(systemName: "xmark.circle")),
                AnyView(Text("/path/to/file/or/dirrectory")), AnyView(Image(systemName: "xmark.circle")),
                AnyView(Text("/path/to/file/or/dirrectory")), AnyView(Image(systemName: "xmark.circle")),
            ]
        )
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

#Preview {
    Bookmarks()
        .frame(maxWidth: 300)
        .padding(20)
}
