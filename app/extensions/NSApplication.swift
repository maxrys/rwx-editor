
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSApplication {

    static func showAppsDock() { Self.shared.setActivationPolicy(.regular  ) }
    static func hideAppsDock() { Self.shared.setActivationPolicy(.accessory) }

}
