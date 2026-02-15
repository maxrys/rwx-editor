
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

public enum Flexibility {
    case none
    case size(CGFloat)
    case infinity
}

public enum KeyEquivalentPolyfill: String {
    case upArrow    = "\u{f700}"
    case downArrow  = "\u{f701}"
    case leftArrow  = "\u{f702}"
    case rightArrow = "\u{f703}"
    case `return`   = "\u{000d}"
}

extension View {

    @ViewBuilder func flexibility(_ value: Flexibility = .none) -> some View {
        switch value {
            case .size(let size): self.frame(width: size)
            case .infinity      : self.frame(maxWidth: .infinity)
            case .none          : self
        }
    }

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

    @ViewBuilder func onKeyPressPolyfill(character: String, action: @escaping () -> Void) -> some View {
        if #available(macOS 14.0, *) {
            self.onKeyPress(phases: .down) { press in
                if (press.characters.contains(character)) { action() }
                return .ignored
            }
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
