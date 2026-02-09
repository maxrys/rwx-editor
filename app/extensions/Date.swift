
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

extension Date {

    enum VisibilityMode: CaseIterable & Equatable {
        case convenient
        case iso8601withTZ
        case iso8601
    }

    enum Format: String {
        case iso8601         = "yyyy-MM-dd HH:mm:ss"
        case iso8601Timezone = "yyyy-MM-dd HH:mm:ss Z"
        case convenientDate  = "d MMM yyyy"
        case convenientTime  = "HH:mm:ss"
    }

    var convenient: String {
        let formatter = DateFormatter()
        formatter.dateFormat = String(
            format: NSLocalizedString("%@ 'at' %@", comment: ""),
            Self.Format.convenientDate.rawValue,
            Self.Format.convenientTime.rawValue )
        return formatter.string(from: self)
    }

    var ISO8601withTZ: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Self.Format.iso8601Timezone.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }

    var ISO8601: String {
        let formatter = DateFormatter()
        formatter.dateFormat = Self.Format.iso8601Timezone.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter.string(from: self)
    }

}
