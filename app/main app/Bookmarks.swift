
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
        VStack(spacing: 15) {

            Text(NSLocalizedString("Allowed directories", comment: ""))
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
                    colorStyle: .accent,
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
