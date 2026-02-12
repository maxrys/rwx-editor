
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PickerCustom<Key>: View where Key: Hashable & Comparable {

    @State private var isOpened: Bool
    @State private var hovered: Key?
           private var selected: Binding<Key>

    private let values: [Key: String]
    private let isPlainListStyle: Bool
    private let flexibility: Flexibility

    init(selected: Binding<Key>, values: [Key: String], isPlainListStyle: Bool = false, flexibility: Flexibility = .none) {
        self.selected         = selected
        self.values           = values
        self.isPlainListStyle = isPlainListStyle
        self.flexibility      = flexibility
        self.isOpened         = false
    }

    var body: some View {
        if (self.values.isEmpty) {
            self.main
                .disabled(true)
        } else {
            self.main
                .popover(isPresented: self.$isOpened) {
                    if (self.values.count <= 10) { self.list }
                    else { ScrollView(.vertical) { self.list }.frame(maxHeight: 370) }
                }
        }
    }

    @ViewBuilder var main: some View {
        Button {
            self.isOpened = true
        } label: {
            Text(self.values[self.selected.wrappedValue] ?? NA_SIGN)
                .lineLimit(1)
                .padding(.horizontal, 9)
                .padding(.vertical  , 5)
                .flexibility(self.flexibility)
                .foregroundPolyfill(Color.picker.text)
                .background(Color.picker.background)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .contentShapePolyfill(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

    @ViewBuilder var list: some View {
        VStack (alignment: .leading, spacing: 6) {
            ForEach(self.values.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                Button {
                    self.selected.wrappedValue = key
                    self.isOpened = false
                } label: {
                    var backgroundColor: Color {
                        if (self.selected.wrappedValue == key) { return Color.accentColor.opacity(0.5) }
                        if (self.hovered               == key) { return Color.accentColor.opacity(0.2) }
                        return self.isPlainListStyle ?
                            Color.clear :
                            Color.picker.itemBackground
                    }
                    Text(value)
                        .lineLimit(1)
                        .padding(.horizontal, 9)
                        .padding(.vertical  , 5)
                        .frame(maxWidth: .infinity, alignment: self.isPlainListStyle ? .leading : .center)
                        .foregroundPolyfill(Color.picker.itemText)
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

        let valuesV1: [UInt: String] = [:]

        VStack {
            Text("No value:")
            PickerCustom<UInt>(selected: $selectedV1, values: valuesV1, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV1, values: valuesV1)
        }

        /* single value */

        let valuesV2: [UInt: String] = [
            0: "Single value"
        ]

        VStack {
            Text("Single value:")
            PickerCustom<UInt>(selected: $selectedV2, values: valuesV2, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV2, values: valuesV2)
        }

        /* multiple values */

        let valuesV3 = {
            (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
                if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
                else        { result[UInt(i)] = "Value \(i)" }
            }
        }()

        VStack {
            Text("Multiple values:")
            PickerCustom<UInt>(selected: $selectedV3, values: valuesV3, isPlainListStyle: true)
            PickerCustom<UInt>(selected: $selectedV3, values: valuesV3)
        }

    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var selected: UInt = 0

    let values = {
        (0 ..< 100).reduce(into: [UInt: String]()) { result, i in
            if (i == 5) { result[UInt(i)] = "Value \(i) long long long long long long" }
            else        { result[UInt(i)] = "Value \(i)" }
        }
    }()

    VStack {
        Text("Flexibility:")
        PickerCustom<UInt>(selected: $selected, values: values)
        PickerCustom<UInt>(selected: $selected, values: values, flexibility: .none)
        PickerCustom<UInt>(selected: $selected, values: values, flexibility: .size(100))
        PickerCustom<UInt>(selected: $selected, values: values, flexibility: .infinity)
    }
    .padding(20)
    .frame(width: 200)
    .background(Color.gray)
}
