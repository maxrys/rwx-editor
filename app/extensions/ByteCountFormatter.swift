
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension ByteCountFormatter {

    enum VisibilityMode: String, CaseIterable & Equatable {
        case bytes  = "Bytes"
        case kbytes = "KBytes"
        case mbytes = "MBytes"
        case gbytes = "GBytes"
        case tbytes = "TBytes"
    }

    static func format(_ value: UInt, unit: ByteCountFormatter.Units = .useBytes) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [unit]
        formatter.countStyle = .binary
        formatter.isAdaptive = false
        return formatter.string(
            fromByteCount: Int64(value)
        )
    }

}
