
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import OpenDirectory

extension ODRecord {

    func stringValue(forAttribute attr: String) -> String? {
        return (try? self.values(forAttribute: attr) as? [String])?.first
    }

    func stringArray(forAttribute attr: String) -> [String] {
        return (try? values(forAttribute: attr) as? [String]) ?? []
    }

}

extension ODQuery {

    static func users() -> [(name: String, uid: Int, title: String?)] {
        do {
            let odSession = ODSession.default()
            let odNode  = try ODNode(session: odSession, name: "/Local/Default")
            let odQuery = try ODQuery(node: odNode, forRecordTypes: kODRecordTypeUsers, attribute: kODAttributeTypeRecordName, matchType: ODMatchType(kODMatchAny), queryValues: nil, returnAttributes: kODAttributeTypeStandardOnly, maximumResults: 0)
            let odItems = try odQuery.resultsAllowingPartial(false) as? [ODRecord] ?? []
            return odItems.compactMap { record in
                let name   = record.stringValue(forAttribute: kODAttributeTypeRecordName)
                let uidStr = record.stringValue(forAttribute: kODAttributeTypeUniqueID)
                let title  = record.stringValue(forAttribute: kODAttributeTypeFullName)
                if let name, let uidStr, let uid = Int(uidStr) {
                    return (
                        name: name,
                        uid: uid,
                        title: title
                    )
                }
                return nil
            }
        } catch {
            return []
        }
    }

    static func groups() -> [(name: String, gid: Int, members: [String])] {
        do {
            let odSession = ODSession.default()
            let odNode  = try ODNode(session: odSession, name: "/Local/Default")
            let odQuery = try ODQuery(node: odNode, forRecordTypes: kODRecordTypeGroups, attribute: kODAttributeTypeRecordName, matchType: ODMatchType(kODMatchAny), queryValues: nil, returnAttributes: kODAttributeTypeStandardOnly, maximumResults: 0)
            let odItems = try odQuery.resultsAllowingPartial(false) as? [ODRecord] ?? []
            return odItems.compactMap { record in
                let name    = record.stringValue(forAttribute: kODAttributeTypeRecordName)
                let gidStr  = record.stringValue(forAttribute: kODAttributeTypePrimaryGroupID)
                let members = record.stringArray(forAttribute: kODAttributeTypeGroupMembership)
                if let name, let gidStr, let gid = Int(gidStr) {
                    return (
                        name: name,
                        gid: gid,
                        members: members
                    )
                }
                return nil
            }
        } catch {
            return []
        }
    }

}
