
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxColored: View {

    static private let ICON_SIZE: CGFloat = 25

    @Binding private var perms: PermissionsValue

    private let isDisabled: Bool
    private let subject: PermissionSubject
    private let permission: Permission

    private var bitPosition: UInt {
        self.subject.offset + self.permission.offset
    }

    private var isOn: Bool {
        self.perms[
            self.bitPosition
        ]
    }

    init(
        subject: PermissionSubject,
        permission: Permission,
        _ perms: Binding<PermissionsValue>,
        isDisabled: Bool = false
    ) {
        self.subject    = subject
        self.permission = permission
        self._perms     = perms
        self.isDisabled = isDisabled
    }

    var background: Color {
        switch self.subject {
            case .owner: Color.toggleRWXColored.owner
            case .group: Color.toggleRWXColored.group
            case .other: Color.toggleRWXColored.other
        }
    }

    public var body: some View {
        Button {
            self.perms[self.bitPosition].toggle()
        } label: {
            if (self.isOn) {
                ZStack {
                    Circle()
                        .fill(self.background)
                        .frame(width: Self.ICON_SIZE, height: Self.ICON_SIZE)
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundPolyfill(Color.white)
                }
            } else {
                Circle()
                    .fill(Color.toggleRWXColored.empty)
                    .frame(width: Self.ICON_SIZE, height: Self.ICON_SIZE)
            }
        }
        .disabled(self.isDisabled)
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill()
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct ToggleRwxColored_Previews: PreviewProvider {
    struct ViewWithState: View {
        @State private var perms: UInt = 0o644
        var body: some View {
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    ToggleRwxColored(subject: .owner, permission: .r, self.$perms)
                    ToggleRwxColored(subject: .group, permission: .x, self.$perms)
                    ToggleRwxColored(subject: .other, permission: .w, self.$perms)
                }
                HStack(spacing: 10) {
                    ToggleRwxColored(subject: .owner, permission: .r, self.$perms, isDisabled: true)
                    ToggleRwxColored(subject: .group, permission: .x, self.$perms, isDisabled: true)
                    ToggleRwxColored(subject: .other, permission: .w, self.$perms, isDisabled: true)
                }
            }.padding(20)
        }
    }
    static var previews: some View {
        ViewWithState()
    }
}
