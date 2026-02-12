
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerCustom<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    @Binding fileprivate var selectedKey: Key
    @State fileprivate var isOpened: Bool = false
    @State fileprivate var hovered: Key?

    fileprivate let items: [Key: String]
    fileprivate let isPlainListStyle: Bool
    fileprivate let flexibility: Flexibility
    fileprivate let colorSet: ColorSet
    fileprivate let cornerRadius: CGFloat = 10
    fileprivate let borderWidth: CGFloat = 0

    init(
        selected: Binding<Key>,
        items: [Key: String],
        isPlainListStyle: Bool = false,
        flexibility: Flexibility = .none,
        colorSet: ColorSet = Color.picker
    ) {
        self._selectedKey = selected
        self.items = items
        self.isPlainListStyle = isPlainListStyle
        self.flexibility = flexibility
        self.colorSet = colorSet
    }

    var body: some View {
        if (self.items.isEmpty) {
            self.opener
                .disabled(true)
        } else {
            self.opener
                .popover(isPresented: self.$isOpened) {
                    if (self.items.count <= 10) { self.list }
                    else { ScrollView(.vertical) { self.list }.frame(maxHeight: 370) }
                }
        }
    }

    @ViewBuilder var opener: some View {
        Button {
            self.isOpened = true
        } label: {
            Text(self.items[self.selectedKey] ?? NOT_APPLICABLE)
                .lineLimit(1)
                .padding(.horizontal, 9)
                .padding(.vertical  , 5)
                .flexibility(self.flexibility)
                .foregroundPolyfill(self.colorSet.text)
                .background(
                    RoundedRectangle(cornerRadius: self.cornerRadius)
                        .stroke(self.colorSet.border, lineWidth: self.borderWidth)
                        .background(self.colorSet.background))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .contentShapePolyfill(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

    @ViewBuilder var list: some View {
        VStack (alignment: .leading, spacing: 6) {
            ForEach(self.items.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Button {
                    self.selectedKey = key
                    self.isOpened = false
                } label: {
                    var backgroundColor: Color {
                        if (self.selectedKey == key) { return Color.accentColor.opacity(0.5) }
                        if (self.hovered     == key) { return Color.accentColor.opacity(0.2) }
                        return self.isPlainListStyle ?
                            Color.clear :
                            self.colorSet.itemBackground
                    }
                    Text(value)
                        .lineLimit(1)
                        .padding(.horizontal, 9)
                        .padding(.vertical  , 5)
                        .frame(maxWidth: .infinity, alignment: self.isPlainListStyle ? .leading : .center)
                        .foregroundPolyfill(self.colorSet.itemText)
                        .background(backgroundColor)
                        .contentShapePolyfill(RoundedRectangle(cornerRadius: 10))
                        .cornerRadius(10)
                        .onHover { isHovered in
                            self.hovered = isHovered ? key : nil
                        }
                }.buttonStyle(.plain)
            }
        }.padding(10)
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selectedV1: UInt = 0
    @Previewable @State var selectedV2: UInt = 0
    @Previewable @State var selectedV3: UInt = 0

    VStack(spacing: 20) {

        /* no value */

        let itemsV1: [UInt: String] = [:]

        VStack {
            Text("No value:")
            PickerCustom<UInt>(selected: $selectedV1, items: itemsV1, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV1, items: itemsV1)
        }

        /* single value */

        let itemsV2: [UInt: String] = [
            0: "Single value"
        ]

        VStack {
            Text("Single value:")
            PickerCustom<UInt>(selected: $selectedV2, items: itemsV2, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV2, items: itemsV2)
        }

        /* multiple values */

        let itemsV3 = {
            (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
                if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
                else        { result[UInt(i)] = "Value \(i)" }
            }
        }()

        VStack {
            Text("Multiple values:")
            PickerCustom<UInt>(selected: $selectedV3, items: itemsV3, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV3, items: itemsV3)
        }

    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: UInt = 0

    let items = {
        (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    VStack {
        Text("Flexibility:")
        PickerCustom<UInt>(selected: $selected, items: items)
        PickerCustom<UInt>(selected: $selected, items: items, flexibility: .none)
        PickerCustom<UInt>(selected: $selected, items: items, flexibility: .size(100))
        PickerCustom<UInt>(selected: $selected, items: items, flexibility: .infinity)
    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}
