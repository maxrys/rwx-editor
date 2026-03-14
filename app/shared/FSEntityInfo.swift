
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

    static func == (lhs: FSEntityInfo, rhs: FSEntityInfo) -> Bool {
        return Self.equalViaMirror(lhs: lhs, rhs: rhs)
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
    public private(set) var size: UInt?

    public let perms: PermissionsValue
    public let owner: String
    public let group: String
    public let isValidbookmark: Bool

    init?(_ fullpath: String) {

        guard !fullpath.isEmpty else {
            return nil
        }
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: fullpath) else {
            return nil
        }

        let fullpathURL = URL(fileURLWithPath: fullpath)
        self.fullpath = fullpath

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

        let (path, name) = Self.parseFullpath(fullpathURL.normalized())
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

        if let subtype = try? fullpathURL.resourceValues(forKeys: [.isAliasFileKey, .isSymbolicLinkKey, .isRegularFileKey]) {
            switch (subtype.isRegularFile, subtype.isAliasFile, subtype.isSymbolicLink) {
                case (true, true, false):
                    self.type = .alias
                case (false, true, true):
                    let (realPath, realName) = Self.parseFullpath(
                        fullpathURL.resolvingSymlinksInPath().normalized()
                    )
                    self.realName = realName
                    self.realPath = realPath
                    self.type     = .link
                default: break
            }
        }

        self.isValidbookmark = BookmarkValue(
            searchValidBy: self.fullpath
        )?.info.isExpired == false

    }

    static public func parseFullpath(_ fullpath: String) -> (path: String, name: String) {
        let components = fullpath.components(
            separatedBy: "/"
        )

        if (components.count >= 2) {
            let path = components.dropLast().joined(separator: "/")
            let name = components.last!
            return (
                path: path.hasSuffix("/") ? path : path + "/",
                name: name
            )
        }

        return (path: "/", name: "")
    }

}
