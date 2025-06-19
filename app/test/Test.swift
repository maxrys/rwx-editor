
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Testing

struct Test {

    let prettyResult: (UInt) -> String = { value in
        String("0b") + String(value, radix: 2).paddingLeft(toLength: 9, withPad: "0")
    }

    @Test func all() throws {
        try? self.bitGet()
        try? self.bitSet()
        try? self.bitToggle()
        try? self.string()
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
                #expect(expected == received)
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
        value = 0b000000000;  value[0] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[1] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[2] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[3] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[4] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[5] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[6] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[7] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[8] = isOn;  expected = "0b000000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        isOn = true
        print("bitSet (value: 0b000000000, isOn: \(isOn)):")
        value = 0b000000000;  value[0] = isOn;  expected = "0b000000001";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[1] = isOn;  expected = "0b000000010";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[2] = isOn;  expected = "0b000000100";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[3] = isOn;  expected = "0b000001000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[4] = isOn;  expected = "0b000010000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[5] = isOn;  expected = "0b000100000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[6] = isOn;  expected = "0b001000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[7] = isOn;  expected = "0b010000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[8] = isOn;  expected = "0b100000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        isOn = false
        print("bitSet (value: 0b111111111, isOn: \(isOn)):")
        value = 0b111111111;  value[0] = isOn;  expected = "0b111111110";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[1] = isOn;  expected = "0b111111101";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[2] = isOn;  expected = "0b111111011";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[3] = isOn;  expected = "0b111110111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[4] = isOn;  expected = "0b111101111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[5] = isOn;  expected = "0b111011111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[6] = isOn;  expected = "0b110111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[7] = isOn;  expected = "0b101111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[8] = isOn;  expected = "0b011111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        isOn = true
        print("bitSet (value: 0b111111111, isOn: \(isOn)):")
        value = 0b111111111;  value[0] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[1] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[2] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[3] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[4] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[5] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[6] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[7] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[8] = isOn;  expected = "0b111111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
    }

    func bitToggle() throws {
        var value: UInt
        var received: String
        var expected: String

        print("bitToggle (value: 0b000000000):")
        value = 0b000000000;  value[0].toggle();  expected = "0b000000001";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[1].toggle();  expected = "0b000000010";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[2].toggle();  expected = "0b000000100";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[3].toggle();  expected = "0b000001000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[4].toggle();  expected = "0b000010000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[5].toggle();  expected = "0b000100000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[6].toggle();  expected = "0b001000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[7].toggle();  expected = "0b010000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b000000000;  value[8].toggle();  expected = "0b100000000";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)

        print("bitToggle (value: 0b111111111):")
        value = 0b111111111;  value[0].toggle();  expected = "0b111111110";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[1].toggle();  expected = "0b111111101";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[2].toggle();  expected = "0b111111011";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[3].toggle();  expected = "0b111110111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[4].toggle();  expected = "0b111101111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[5].toggle();  expected = "0b111011111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[6].toggle();  expected = "0b110111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[7].toggle();  expected = "0b101111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
        value = 0b111111111;  value[8].toggle();  expected = "0b011111111";  received = self.prettyResult(value);  print("\(expected) = \(received)");  #expect(expected == received)
    }

    func string() throws {

        let string = "Привет!"

        #expect(string[0] == "П")
        #expect(string[1] == "р")
        #expect(string[2] == "и")
        #expect(string[3] == "в")
        #expect(string[4] == "е")
        #expect(string[5] == "т")
        #expect(string[6] == "!")

        #expect(string[-7] == "П")
        #expect(string[-6] == "р")
        #expect(string[-5] == "и")
        #expect(string[-4] == "в")
        #expect(string[-3] == "е")
        #expect(string[-2] == "т")
        #expect(string[-1] == "!")

        #expect(string[0, 0] == "П")
        #expect(string[0, 1] == "Пр")
        #expect(string[0, 2] == "При")
        #expect(string[0, 3] == "Прив")
        #expect(string[0, 4] == "Приве")
        #expect(string[0, 5] == "Привет")
        #expect(string[0, 6] == "Привет!")

        #expect(string[3, 3] == "в")
        #expect(string[3, 4] == "ве")
        #expect(string[3, 5] == "вет")
        #expect(string[3, 6] == "вет!")

        #expect(string[-100] == "П")
        #expect(string[+100] == "!")

        #expect(string[100,   0] == "Привет!")
        #expect(string[  0, 100] == "Привет!")
        #expect(string[  3,   1] == "рив")
        #expect(string[100,   1] == "ривет!")

    }

}
