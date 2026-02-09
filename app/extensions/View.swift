
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension View {

    @ViewBuilder public func textSelectionPolyfill(isEnabled: Bool = true) -> some View {
        if #available(macOS 12.0, *) {
            if (isEnabled == true) { self.textSelection(.enabled ) }
            if (isEnabled != true) { self.textSelection(.disabled) }
        } else { self }
    }

}
