
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct PanelRwxText: View {

    enum ColorNames: String {
        case text       = "color Panel RWX Text Text"
        case background = "color Panel RWX Text Background"
    }

    private var rights: Binding<UInt>

    init(_ rights: Binding<UInt>) {
        self.rights = rights
    }

    let isOn: (UInt, UInt) -> Bool = { rightsValue, bitPosition in
        rightsValue[bitPosition]
    }

    var body: some View {
        let rightsValue = self.rights.wrappedValue
        let symbolR = Permission.r.rawValue
        let symbolW = Permission.w.rawValue
        let symbolX = Permission.x.rawValue
        let symbolE = "-"
        let text = String(
            "\( self.isOn(rightsValue, Subject.owner.offset + Permission.r.offset) ? symbolR : symbolE )\( self.isOn(rightsValue, Subject.owner.offset + Permission.w.offset) ? symbolW : symbolE )\( self.isOn(rightsValue, Subject.owner.offset + Permission.x.offset) ? symbolX : symbolE )" +
            "\( self.isOn(rightsValue, Subject.group.offset + Permission.r.offset) ? symbolR : symbolE )\( self.isOn(rightsValue, Subject.group.offset + Permission.w.offset) ? symbolW : symbolE )\( self.isOn(rightsValue, Subject.group.offset + Permission.x.offset) ? symbolX : symbolE )" +
            "\( self.isOn(rightsValue, Subject.other.offset + Permission.r.offset) ? symbolR : symbolE )\( self.isOn(rightsValue, Subject.other.offset + Permission.w.offset) ? symbolW : symbolE )\( self.isOn(rightsValue, Subject.other.offset + Permission.x.offset) ? symbolX : symbolE )"
        )
        Text(text)
            .font(.system(size: 13, weight: .regular, design: .monospaced))
            .padding(.init(top: 4, leading: 9, bottom: 6, trailing: 9))
            .foregroundPolyfill(Color(Self.ColorNames.text.rawValue))
            .background(Color(Self.ColorNames.background.rawValue))
            .cornerRadius(5)
            .textSelectionPolyfill()
    }

}

@available(macOS 14.0, *) #Preview {
    @Previewable @State var rights: UInt = 0o644
    HStack {
        PanelRwxText($rights)
    }.padding(20)
}
