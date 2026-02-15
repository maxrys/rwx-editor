
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerCustom<Key>: View where Key: Hashable & Comparable {

    typealias ColorSet = Color.PickerColorSet

    @Binding fileprivate var selectedKey: Key
    @State fileprivate var isOpened = false

    fileprivate let items: [Key: String]
    fileprivate let sortedBy: Dictionary<Key, String>.SortedBy
    fileprivate let isPlainListStyle: Bool
    fileprivate let flexibility: Flexibility
    fileprivate let colorSet: ColorSet
    fileprivate let cornerRadius: CGFloat = 10
    fileprivate let borderWidth: CGFloat = 0

    fileprivate var keyToIndex: [Key: Int] = [:]
    fileprivate var indexToKey: [Int: Key] = [:]
    fileprivate var itemsSorted: [(key: Key, value: String)] = []

    init(
        selected: Binding<Key>,
        items: [Key: String],
        sortedBy: Dictionary<Key, String>.SortedBy = .keyAsc,
        isPlainListStyle: Bool = false,
        flexibility: Flexibility = .none,
        colorSet: ColorSet = Color.picker
    ) {
        self._selectedKey = selected
        self.items = items
        self.sortedBy = sortedBy
        self.isPlainListStyle = isPlainListStyle
        self.flexibility = flexibility
        self.colorSet = colorSet
        self.itemsSorted = self.items.sortedBy(order: self.sortedBy)
        self.itemsSorted.enumerated().forEach { index, keyValuePair in
            self.keyToIndex[keyValuePair.key] = index
            self.indexToKey[index] = keyValuePair.key
        }
    }

    private func onPressKeyUpArrow() {
        if let index = self.keyToIndex[self.selectedKey] {
            if let nextKey = self.indexToKey[index + 1] {
                self.selectedKey = nextKey
            }
        }
    }

    private func onPressKeyDownArrow() {
        if let index = self.keyToIndex[self.selectedKey] {
            if let prevKey = self.indexToKey[index - 1] {
                self.selectedKey = prevKey
            }
        }
    }

    var body: some View {
        if (self.items.isEmpty) {
            self.opener
                .disabled(true)
        } else {
            self.opener
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.upArrow  .rawValue, action: self.onPressKeyUpArrow)
                .onKeyPressPolyfill(character: KeyEquivalentPolyfill.downArrow.rawValue, action: self.onPressKeyDownArrow)
                .popover(isPresented: self.$isOpened) {
                    PickerCustomPopover<Key>(
                        rootView: self
                    )
                }
        }
    }

    @ViewBuilder private var opener: some View {
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
                        .background(self.colorSet.background)
                        .clipShape(RoundedRectangle(cornerRadius: self.cornerRadius)))
                .contentShape(RoundedRectangle(cornerRadius: self.cornerRadius))
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}

fileprivate struct PickerCustomPopover<Key>: View where Key: Hashable & Comparable {

    @State private var hoveredKey: Key?

    private var rootView: PickerCustom<Key>

    init(rootView: PickerCustom<Key>) {
        self.rootView = rootView
    }

    public var body: some View {
        if (self.rootView.items.count > 8)
             { List   { self.list }.listStyle(.sidebar) }
        else { VStack { self.list }.padding(10) }
    }

    private var list: some View {
        ForEach(Array(self.rootView.itemsSorted.enumerated()), id: \.element.key) { index, item in
            Button {
                self.rootView.selectedKey = item.key
                self.rootView.isOpened = false
            } label: {
                var backgroundColor: Color {
                    if (self.rootView.selectedKey      == item.key) { return self.rootView.colorSet.itemSelectedBackground }
                    if (self.hoveredKey                == item.key) { return self.rootView.colorSet.itemHoveringBackground }
                    if (self.rootView.isPlainListStyle == false   ) { return self.rootView.colorSet.itemBackground }
                    return Color.clear
                }
                Text(item.value)
                    .lineLimit(1)
                    .padding(.horizontal, 9)
                    .padding(.vertical  , 5)
                    .frame(maxWidth: .infinity, alignment: self.rootView.isPlainListStyle ? .leading : .center)
                    .foregroundPolyfill(self.rootView.colorSet.itemText)
                    .background(
                        RoundedRectangle(cornerRadius: self.rootView.cornerRadius)
                            .fill(backgroundColor))
                    .contentShape(RoundedRectangle(cornerRadius: self.rootView.cornerRadius))
                    .onHover { isHovering in
                        self.hoveredKey = isHovering ? item.key : nil
                    }
            }
            .pointerStyleLinkPolyfill()
            .buttonStyle(.plain)
            .id(index)
        }
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

fileprivate func generatePreviewItems_intKey(count: Int) -> [UInt: String] {
    (1000 ..< 1000 + count).reduce(into: [UInt: String]()) { result, i in
        if (i == 1005) { result[UInt(i)] = "Value \(i) long long long long long long" }
        else           { result[UInt(i)] = "Value \(i)" }
    }
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selectedV1: UInt = 0
    @Previewable @State var selectedV2: UInt = 0
    @Previewable @State var selectedV3: UInt = 0

    VStack(spacing: 20) {

        VStack {
            Text("No value:").font(.headline)
            PickerCustom<UInt>(selected: $selectedV1, items: generatePreviewItems_intKey(count: 0), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV1, items: generatePreviewItems_intKey(count: 0))
        }

        VStack {
            Text("Single value:").font(.headline)
            PickerCustom<UInt>(selected: $selectedV2, items: generatePreviewItems_intKey(count: 1), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV2, items: generatePreviewItems_intKey(count: 1))
        }

        VStack {
            Text("Multiple values:").font(.headline)
            PickerCustom<UInt>(selected: $selectedV3, items: generatePreviewItems_intKey(count: 9), isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV3, items: generatePreviewItems_intKey(count: 9))
        }

    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: UInt = 0
    VStack {
        Text("Flexibility:").font(.headline)
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10))
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10), flexibility: .none)
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10), flexibility: .size(100))
        PickerCustom<UInt>(selected: $selected, items: generatePreviewItems_intKey(count: 10), flexibility: .infinity)
    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}
