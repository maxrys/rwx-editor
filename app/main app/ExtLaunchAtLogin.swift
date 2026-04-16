
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI
import ServiceManagement

@available(macOS 13.0, *) struct ExtLaunchAtLogin: View {

    static public var launchAtLogin: Bool {
        get {
            return SMAppService.mainApp.status == .enabled
        }
        set(isEnabled) {
            if (isEnabled) { try? SMAppService.mainApp.register  () }
            else           { try? SMAppService.mainApp.unregister() }
        }
    }

    @State private var isEnabled: Bool = false

    public var body: some View {
        ToggleCustom(
            text: NSLocalizedString("Launch at login", comment: ""),
            isOn: self.$isEnabled
        )
        .onChange(of: self.isEnabled) { value in Self.launchAtLogin = value }
        .onAppear              {           if (            true           ) { self.isEnabled = Self.launchAtLogin } }
        .onWinBecomeForeground { window in if (window.ID == WINDOW_MAIN_ID) { self.isEnabled = Self.launchAtLogin } }
    }

}


/* ############################################################# */
/* ########################## PREVIEW ########################## */
/* ############################################################# */

@available(macOS 13.0, *) struct ExtLaunchAtLogin_Previews: PreviewProvider {
    static public var previews: some View {
        ExtLaunchAtLogin()
            .frame(maxWidth: 300)
            .padding(20)
    }
}
