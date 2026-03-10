
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
        VStack(spacing: 10) {

            TableCustom(
                selected: self.$selectedItems,
                head: {
                    TableCustom_HeadCell(
                        size: .flexible(),
                        spacing: 1,
                        alignment: .leading
                    ) { Text(NSLocalizedString("Allowed directories", comment: "")).font(.system(size: 11)) }
                },
                bodyAsArray: [
                    AnyView(Text("/path/to/dirrectory")),
                    AnyView(Text("/path/to/dirrectory")),
                    AnyView(Text("/path/to/dirrectory")),
                    AnyView(Text("/path/to/dirrectory")),
                    AnyView(Text("/path/to/dirrectory")),
                ]
            )

            HStack(spacing: 10) {

                ButtonCustom(
                    NSLocalizedString("delete", comment: ""),
                    isDisabled: self.selectedItems.isEmpty,
                    colorStyle: .custom(text: nil, background: nil),
                    isFlat: false,
                    flexibility: .size(100)
                ) { }

                Spacer()

                ButtonCustom(
                    NSLocalizedString("add new directory...", comment: ""),
                    colorStyle: .custom(text: nil, background: nil),
                    isFlat: false,
                    flexibility: .size(200)
                ) { }

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
