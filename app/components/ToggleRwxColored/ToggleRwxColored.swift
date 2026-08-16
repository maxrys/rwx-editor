
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

struct ToggleRwxColored: View {

    static private let ICON_SIZE: CGFloat = 25

    @Environment(\.isEnabled) private var isEnabled
    @Binding private var perms: PermissionsValue

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
        _ perms: Binding<PermissionsValue>
    ) {
        self.subject    = subject
        self.permission = permission
        self._perms     = perms
    }

    var background: Color {
        switch self.subject {
            case .owner: return Color.toggleRWXColored.owner
            case .group: return Color.toggleRWXColored.group
            case .other: return Color.toggleRWXColored.other
        }
    }

    public var body: some View {
        Button {
            self.perms[self.bitPosition].toggle()
        } label: {
            Circle()
                .fill(self.isOn ? self.background : Color.toggleRWXColored.empty)
                .frame(width: Self.ICON_SIZE, height: Self.ICON_SIZE)
                .overlayPolyfill {
                    if (self.isOn) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundPolyfill(Color.white)
                    }
                }.focusEffect(Circle())
        }
        .disabled(!self.isEnabled)
        .buttonStyle(.plain)
        .pointerStyleLinkPolyfill(self.isEnabled)
    }

}



/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct ToggleRwxColored_Previews: PreviewProvider {
    struct ViewWithState: View {
        @State private var perms: UInt = 0o644
        public var body: some View {
            Previewer(padding: 20) {
                HStack(spacing: 10) {
                    ToggleRwxColored(subject: .owner, permission: .r, self.$perms)
                    ToggleRwxColored(subject: .group, permission: .x, self.$perms)
                    ToggleRwxColored(subject: .other, permission: .w, self.$perms)
                }
                HStack(spacing: 10) {
                    ToggleRwxColored(subject: .owner, permission: .r, self.$perms).disabled(true)
                    ToggleRwxColored(subject: .group, permission: .x, self.$perms).disabled(true)
                    ToggleRwxColored(subject: .other, permission: .w, self.$perms).disabled(true)
                }
            }
        }
    }
    static public var previews: some View {
        ViewWithState()
    }
}
