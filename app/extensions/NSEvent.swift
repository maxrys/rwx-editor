
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import AppKit

extension NSEvent {

    static public var isPressedCommandButton: Bool {
        Self.modifierFlags.contains(.command)
    }

    static public var isPressedShiftButton: Bool {
        Self.modifierFlags.contains(.shift)
    }

    static public var isPressedLeftMouseButton: Bool {
        (Self.pressedMouseButtons & 1) != 0
    }

    static public var isPressedMiddleMouseButton: Bool {
        (Self.pressedMouseButtons & 4) != 0
    }

    static public var isPressedRightMouseButton: Bool {
        (Self.pressedMouseButtons & 2) != 0
    }

}
