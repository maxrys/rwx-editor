
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

final class FSEntityInfo {

    public enum FSType {
        case directory
        case file
        case link
        case alias
        case other
    }

    public let fullpath: String

    public private(set) var type: FSType
    public private(set) var name: String
    public private(set) var path: String
    public private(set) var realName: String?
    public private(set) var realPath: String?
    public private(set) var references: UInt
    public private(set) var created: Date
    public private(set) var updated: Date
    public private(set) var size: UInt = 0

    public let rights: UInt
    public let owner: String
    public let group: String

    init?(_ fullpath: String) {

        self.fullpath = fullpath

        guard !fullpath.isEmpty else {
            return nil
        }
        guard let fullpathAsURL = URL(string: "file://\(fullpath)") else {
            return nil
        }
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: fullpath) else {
            return nil
        }

        /* MARK: type */

        switch attributes[.type] as? FileAttributeType {
            case .typeDirectory       : self.type = .directory
            case .typeRegular         : self.type = .file
            case .typeSymbolicLink    : self.type = .link
            case .typeBlockSpecial    : return nil
            case .typeCharacterSpecial: return nil
            case .typeSocket          : return nil
            case .typeUnknown         : return nil
            case .none                : return nil
            case .some(_)             : return nil
        }

        /* MARK: path/name */

        let (path, name) = fullpathAsURL.pathAndName
        self.name = name
        self.path = path

        /* MARK: created/updated/references/rights/owner/group */

        if let created    = attributes[.creationDate]          as? Date   { self.created    = created    } else { return nil }
        if let updated    = attributes[.modificationDate]      as? Date   { self.updated    = updated    } else { return nil }
        if let references = attributes[.referenceCount]        as? UInt   { self.references = references } else { return nil }
        if let rights     = attributes[.posixPermissions]      as? UInt   { self.rights     = rights     } else { return nil }
        if let owner      = attributes[.ownerAccountName]      as? String { self.owner      = owner      } else { return nil }
        if let group      = attributes[.groupOwnerAccountName] as? String { self.group      = group      } else { return nil }

        /* MARK: size */

        if (self.type == .file || self.type == .link) {
            if let size = attributes[.size] as? UInt {
                self.size = size
            }
        }

        /* MARK: realPath/realName */

        if let subtype = try? fullpathAsURL.resourceValues(forKeys: [.isAliasFileKey, .isSymbolicLinkKey, .isRegularFileKey]) {
            switch (subtype.isRegularFile, subtype.isAliasFile, subtype.isSymbolicLink) {
                case (true, true, false):
                    self.type = .alias
                case (false, true, true):
                    self.type = .link
                    let (realPath, realName) = fullpathAsURL.resolvingSymlinksInPath().pathAndName
                    self.realName = realName
                    self.realPath = realPath
                default: break
            }
        }

    }

}
