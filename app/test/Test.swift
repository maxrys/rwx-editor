
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Testing
import Foundation

extension String {

    func paddingLeft(toLength: Int, withPad: String) -> String {
        String(repeating: withPad, count: toLength - self.count) + self
    }

}

struct Test {

    let prettyResult: (UInt) -> String = { value in
        String("0b") + String(value, radix: 2).paddingLeft(toLength: 9, withPad: "0")
    }

    @Test func all() throws {
        try? self.bitGet()
        try? self.bitSet()
        try? self.bitToggle()
        try? self.subjectPermissionGet()
        try? self.subjectPermissionSet()
        try? self.parseFullpath()
    }

    func bitGet() throws {
        print("bitGet:")
        for i in 0 ... 0b111111111 {
            let received = "0b" +
                String(UInt(i)[8] ? 1 : 0) +
                String(UInt(i)[7] ? 1 : 0) +
                String(UInt(i)[6] ? 1 : 0) +
                String(UInt(i)[5] ? 1 : 0) +
                String(UInt(i)[4] ? 1 : 0) +
                String(UInt(i)[3] ? 1 : 0) +
                String(UInt(i)[2] ? 1 : 0) +
                String(UInt(i)[1] ? 1 : 0) +
                String(UInt(i)[0] ? 1 : 0)
            let expected = self.prettyResult(UInt(i))
            print("\(String(i).padding(toLength: 3, withPad: " ", startingAt: 0)): ", terminator: "")
            print("\(received) = \(expected)", terminator: "")
                #expect(received == expected)
            print("")
        }
    }

    func bitSet() throws {
        var value: UInt
        var received: String
        var expected: String
        var isOn: Bool

        isOn = false
        print("bitSet (value: 0b000000000, isOn: \(isOn)):")
        value = 0b000000000;  value[0] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[1] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[2] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[3] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[4] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[5] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[6] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[7] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[8] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)

        isOn = true
        print("bitSet (value: 0b000000000, isOn: \(isOn)):")
        value = 0b000000000;  value[0] = isOn;  expected = "0b000000001";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[1] = isOn;  expected = "0b000000010";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[2] = isOn;  expected = "0b000000100";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[3] = isOn;  expected = "0b000001000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[4] = isOn;  expected = "0b000010000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[5] = isOn;  expected = "0b000100000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[6] = isOn;  expected = "0b001000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[7] = isOn;  expected = "0b010000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[8] = isOn;  expected = "0b100000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)

        isOn = false
        print("bitSet (value: 0b111111111, isOn: \(isOn)):")
        value = 0b111111111;  value[0] = isOn;  expected = "0b111111110";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[1] = isOn;  expected = "0b111111101";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[2] = isOn;  expected = "0b111111011";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[3] = isOn;  expected = "0b111110111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[4] = isOn;  expected = "0b111101111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[5] = isOn;  expected = "0b111011111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[6] = isOn;  expected = "0b110111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[7] = isOn;  expected = "0b101111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[8] = isOn;  expected = "0b011111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)

        isOn = true
        print("bitSet (value: 0b111111111, isOn: \(isOn)):")
        value = 0b111111111;  value[0] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[1] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[2] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[3] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[4] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[5] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[6] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[7] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[8] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
    }

    func bitToggle() throws {
        var value: UInt
        var received: String
        var expected: String

        print("bitToggle (value: 0b000000000):")
        value = 0b000000000;  value[0].toggle();  expected = "0b000000001";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[1].toggle();  expected = "0b000000010";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[2].toggle();  expected = "0b000000100";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[3].toggle();  expected = "0b000001000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[4].toggle();  expected = "0b000010000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[5].toggle();  expected = "0b000100000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[6].toggle();  expected = "0b001000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[7].toggle();  expected = "0b010000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b000000000;  value[8].toggle();  expected = "0b100000000";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)

        print("bitToggle (value: 0b111111111):")
        value = 0b111111111;  value[0].toggle();  expected = "0b111111110";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[1].toggle();  expected = "0b111111101";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[2].toggle();  expected = "0b111111011";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[3].toggle();  expected = "0b111110111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[4].toggle();  expected = "0b111101111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[5].toggle();  expected = "0b111011111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[6].toggle();  expected = "0b110111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[7].toggle();  expected = "0b101111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
        value = 0b111111111;  value[8].toggle();  expected = "0b011111111";  received = self.prettyResult(value);  print("\(received) = \(expected)");  #expect(received == expected)
    }

    func subjectPermissionGet() throws {
        let etalonGetter: (PermissionsValue, PermissionSubject) -> UInt = { perms, subject in
            let bitR = perms[subject.offset + Permission.r.offset]
            let bitW = perms[subject.offset + Permission.w.offset]
            let bitX = perms[subject.offset + Permission.x.offset]
            var result: UInt = 0
                result[Permission.r.offset] = bitR
                result[Permission.w.offset] = bitW
                result[Permission.x.offset] = bitX
            return result
        }
        for perms in PermissionsValue(0) ... PermissionsValue(0o777) {
            let etalonOwner = etalonGetter(perms, .owner)
            let etalonGroup = etalonGetter(perms, .group)
            let etalonOther = etalonGetter(perms, .other)
            let owner = PermissionSubject.owner.permissionGet(from: perms)
            let group = PermissionSubject.group.permissionGet(from: perms)
            let other = PermissionSubject.other.permissionGet(from: perms)
            #expect(etalonOwner == owner)
            #expect(etalonGroup == group)
            #expect(etalonOther == other)
        }
    }

    func subjectPermissionSet() throws {
        let etalonSetter: (UInt, PermissionsValue, PermissionSubject) -> PermissionsValue = { value, permsValue, subject in
            let bitR = value[Permission.r.offset]
            let bitW = value[Permission.w.offset]
            let bitX = value[Permission.x.offset]
            var result = permsValue
                result[subject.offset + Permission.r.offset] = bitR
                result[subject.offset + Permission.w.offset] = bitW
                result[subject.offset + Permission.x.offset] = bitX
            return result
        }
        for perms in PermissionsValue(0) ... PermissionsValue(0o777 + 1) {
            let etalonOwner = etalonSetter(0o1, perms, .owner)
            let etalonGroup = etalonSetter(0o2, perms, .group)
            let etalonOther = etalonSetter(0o3, perms, .other)
            let owner = PermissionSubject.owner.permissionSet(0o1, to: perms)
            let group = PermissionSubject.group.permissionSet(0o2, to: perms)
            let other = PermissionSubject.other.permissionSet(0o3, to: perms)
            #expect(etalonOwner == owner)
            #expect(etalonGroup == group)
            #expect(etalonOther == other)
        }
    }

    func parseFullpath() throws {
        let paths = [
            "/"                      : (path: "/",           name: ""         ),
            "/file"                  : (path: "/",           name: "file"     ),
            "/directory/"            : (path: "/",           name: "directory"),
            "/directory/file"        : (path: "/directory/", name: "file"     ),
            "file:///"               : (path: "/",           name: ""         ),
            "file:///file"           : (path: "/",           name: "file"     ),
            "file:///directory/"     : (path: "/",           name: "directory"),
            "file:///directory/file" : (path: "/directory/", name: "file"     ),
        ]

        for (value, expected) in paths {
            let url = value.hasPrefix("file://") ?
                URL(string: value)! :
                URL(fileURLWithPath: value)
            let received = FSEntityInfo.parseFullpath(url.normalized())
            print("pathAndName: \(value) | (\(received.path),\(received.name)) = (\(expected.path),\(expected.name))")
            #expect(received == expected)
        }
    }

}
