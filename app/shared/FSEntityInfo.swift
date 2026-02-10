
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

public enum FSType {

    case directory
    case file
    case link
    case alias
    case other

}

final class FSEntityInfo {

    public let fullpath: String

    public let type: FSType
    public let name: String
    public let path: String
    public var realName: String?
    public var realPath: String?
    public let references: UInt
    public let created: Date
    public let updated: Date
    public let size: UInt

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

        var typeResolved: FSType

        switch attributes[.type] as? FileAttributeType {
            case .typeDirectory       : typeResolved = .directory
            case .typeRegular         : typeResolved = .file
            case .typeSymbolicLink    : typeResolved = .link
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

        var sizeResolved: UInt = 0

        if (typeResolved == .file || typeResolved == .link) {
            if let size = attributes[.size] as? UInt {
                sizeResolved = size
            }
        }

        self.size = sizeResolved

        /* MARK: realPath/realName */

        if let subtype = try? fullpathAsURL.resourceValues(forKeys: [.isAliasFileKey, .isSymbolicLinkKey, .isRegularFileKey]) {
            switch (subtype.isRegularFile, subtype.isAliasFile, subtype.isSymbolicLink) {
                case (true, true, false):
                    typeResolved = .alias
                case (false, true, true):
                    typeResolved = .link
                    let (realPath, realName) = fullpathAsURL.resolvingSymlinksInPath().pathAndName
                    self.realName = realName
                    self.realPath = realPath
                default: break
            }
        }

        /* MARK: type */

        self.type = typeResolved

    }

}
