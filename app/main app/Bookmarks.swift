
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
                    ) { Text(NSLocalizedString("Permitted path", comment: "")).font(.system(size: 11)) }
                },
                bodyAsArray: [
                    AnyView(Text("/path/to/file/or/dirrectory")),
                    AnyView(Text("/path/to/file/or/dirrectory")),
                    AnyView(Text("/path/to/file/or/dirrectory")),
                    AnyView(Text("/path/to/file/or/dirrectory")),
                    AnyView(Text("/path/to/file/or/dirrectory")),
                ]
            )

            HStack(spacing: 10) {

                ButtonCustom(
                    NSLocalizedString("delete", comment: ""),
                    isDisabled: self.selectedItems.isEmpty,
                    colorStyle: .custom(text: nil, background: nil),
                    isFlat: false,
                    flexibility: .size(150)
                ) { }

                Spacer()

                ButtonCustom(
                    NSLocalizedString("add new...", comment: ""),
                    colorStyle: .custom(text: nil, background: nil),
                    isFlat: false,
                    flexibility: .size(150)
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
