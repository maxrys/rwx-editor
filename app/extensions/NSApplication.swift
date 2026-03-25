
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSApplication {

    static func show() { NSApp.activate(ignoringOtherApps: true) }
    static func showAppsDock() { Self.shared.setActivationPolicy(.regular  ) }
    static func hideAppsDock() { Self.shared.setActivationPolicy(.accessory) }

}
