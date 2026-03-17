
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import ServiceManagement

struct ExtLaunchAtLogin: View {

    static var launchAtLogin: Bool {
        get {
            if #available(macOS 13.0, *)
                 { return SMAppService.mainApp.status == .enabled }
            else { return false }
        }
        set(isEnabled) {
            do {
                if #available(macOS 13.0, *) {
                    if (isEnabled) { try SMAppService.mainApp.register  () }
                    else           { try SMAppService.mainApp.unregister() }
                }
            } catch {}
        }
    }

    @State private var isEnabled: Bool

    init() {
        self.isEnabled = false
    }

    var body: some View {
        ToggleCustom(
            text: NSLocalizedString("Launch at login", comment: ""),
            isOn: self.$isEnabled
        )
        .onChange(of: self.isEnabled) { value in Self.launchAtLogin = value }
        .onAppear              {           if (            true           ) {  self.isEnabled = Self.launchAtLogin } }
        .onWinBecomeForeground { window in if (window.ID == WINDOW_MAIN_ID) {  self.isEnabled = Self.launchAtLogin } }
    }

}


/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

struct ExtLaunchAtLogin_Previews: PreviewProvider {
    static var previews: some View {
        ExtLaunchAtLogin()
            .frame(maxWidth: 300)
            .padding(20)
    }
}
