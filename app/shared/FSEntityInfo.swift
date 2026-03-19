
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

final class FSEntityInfo: Equatable {

    public enum FSType {
        case directory
        case file
        case link
        case alias
        case other
    }

    public enum EditabilityMode {
        case allowed
        case noBookmark
        case notOwner
    }

    static func == (lhs: FSEntityInfo, rhs: FSEntityInfo) -> Bool {
        return Self.equalViaMirror(lhs: lhs, rhs: rhs)
    }

    public let url: URL

    public private(set) var type: FSType
    public private(set) var name: String
    public private(set) var path: String
    public private(set) var realName: String?
    public private(set) var realPath: String?
    public private(set) var references: UInt
    public private(set) var created: Date
    public private(set) var updated: Date
    public private(set) var size: UInt?

    public let perms: PermissionsValue
    public let owner: String
    public let group: String

    public var editabilityMode: EditabilityMode

    init?(_ url: URL) {

        self.url = url

        guard let attributes = try? FileManager.default.attributesOfItem(atPath: url.path) else {
            return nil
        }

        /* MARK: type */

        if let attribute = attributes[.type] as? FileAttributeType {
            switch attribute {
                case .typeDirectory   : self.type = .directory
                case .typeRegular     : self.type = .file
                case .typeSymbolicLink: self.type = .link
                default: return nil
            }
        } else {
            return nil
        }

        /* MARK: path/name */

        let (path, name) = url.pathAndNamePair
        self.name = name
        self.path = path

        /* MARK: created/updated/references/perms/owner/group */

        if let created    = attributes[.creationDate]          as? Date             { self.created    = created    } else { return nil }
        if let updated    = attributes[.modificationDate]      as? Date             { self.updated    = updated    } else { return nil }
        if let references = attributes[.referenceCount]        as? UInt             { self.references = references } else { return nil }
        if let perms      = attributes[.posixPermissions]      as? PermissionsValue { self.perms      = perms      } else { return nil }
        if let owner      = attributes[.ownerAccountName]      as? String           { self.owner      = owner      } else { return nil }
        if let group      = attributes[.groupOwnerAccountName] as? String           { self.group      = group      } else { return nil }

        /* MARK: size */

        if (self.type == .file || self.type == .link) {
            if let size = attributes[.size] as? UInt {
                self.size = size
            }
        }

        /* MARK: realPath/realName */

        if let subtype = try? url.resourceValues(forKeys: [.isAliasFileKey, .isSymbolicLinkKey, .isRegularFileKey]) {
            switch (subtype.isRegularFile, subtype.isAliasFile, subtype.isSymbolicLink) {
                case (true, true, false):
                    self.type = .alias
                case (false, true, true):
                let (realPath, realName) = url.resolvingSymlinksInPath().pathAndNamePair
                    self.realName = realName
                    self.realPath = realPath
                    self.type     = .link
                default: break
            }
        }

        if (Process.currentUserName != self.owner)         { self.editabilityMode = .notOwner }
        else if (BookmarkValue(searchValidBy: url) == nil) { self.editabilityMode = .noBookmark }
        else                                               { self.editabilityMode = .allowed }

    }

}
