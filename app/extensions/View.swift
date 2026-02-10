
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension View {

    @ViewBuilder func foregroundPolyfill(_ color: Color) -> some View {
        if #available(macOS 14.0, iOS 17.0, *) { self.foregroundStyle(color) }
        else                                   { self.foregroundColor(color) }
    }

    @ViewBuilder public func textSelectionPolyfill(isEnabled: Bool = true) -> some View {
        if #available(macOS 12.0, *) {
            if (isEnabled == true) { self.textSelection(.enabled ) }
            if (isEnabled != true) { self.textSelection(.disabled) }
        } else { self }
    }

    @ViewBuilder func pointerStyleLinkPolyfill(isEnabled: Bool = true) -> some View {
        if (isEnabled) {
            if #available(macOS 15.0, *) {
                self.pointerStyle(.link)
            } else {
                self.onHover { isInView in
                    if (isInView) { NSCursor.pointingHand.push() }
                    else          { NSCursor.pop() }
                }
            }
        } else {
            self
        }
    }

}
