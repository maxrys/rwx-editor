
/* ############################################################# */
/* ### Copyright © 2026 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSWindow {

    static public var customWindows: [
        String: NSWindow
    ] = [:]

    static func get(_ ID: String) -> NSWindow? {
        if let window = self.customWindows[ID] { return window }
        for window in NSApplication.shared.windows {
            if let foundID = window.ID {
                if foundID == ID {
                    return window
                }
            }
        }
        return nil
    }

    static func makeAndShowFromSwiftUIView(
        ID: String,
        title: String,
        styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable],
        isVisible: Bool = true,
        level: NSWindow.Level = .normal,
        size: CGSize = CGSize(width: 1000, height: 1000),
        isReleasedWhenClosed: Bool = false,
        delegate: any NSWindowDelegate,
        view: some View
    ) -> Bool {
        if let window = Self.customWindows[ID] {
            window.show()
            return true
        }

        let hostingView = NSHostingView(
            rootView: view
        )

        Self.customWindows[ID] = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: size.width, height: size.height),
            styleMask: styleMask,
            backing: .buffered,
            defer: false
        )

        guard let window = Self.customWindows[ID] else {
            return false
        }

        window.identifier = NSUserInterfaceItemIdentifier(ID)
        window.delegate = delegate
        window.contentView = hostingView
        window.isReleasedWhenClosed = isReleasedWhenClosed
        window.title = title
        window.level = level

        if (isVisible) {
            window.show()
            window.center()
        } else {
            window.hide()
        }
        return true
    }

    static func show(_ ID: String) { Self.get(ID)?.makeKeyAndOrderFront(nil) }
    static func hide(_ ID: String) { Self.get(ID)?.orderOut(nil) }

    static func hideWithAnimation(_ ID: String, onComplete: @escaping () -> Void = {}) {
        if let window = Self.get(ID) {
            if (window.isVisible) {
                let steps: UInt = 10
                _ = Timer.Custom(
                    repeats: .count(steps),
                    delay: 0.01,
                    onTick: { timer in
                        let opacity = CGFloat(steps - timer.i - 1) * 0.1
                        window.alphaValue = opacity
                    },
                    onExpire: { _ in
                        window.hide()
                        window.alphaValue = 1.0
                        onComplete()
                    }
                )
            }
        }
    }

    func show() { self.makeKeyAndOrderFront(nil) }
    func hide() { self.orderOut(nil) }

    func hideTitleButtons(isVisible: Bool = true) {
        self.standardWindowButton(.closeButton      )?.isHidden = !isVisible
        self.standardWindowButton(.miniaturizeButton)?.isHidden = !isVisible
        self.standardWindowButton(.zoomButton       )?.isHidden = !isVisible
    }

    var ID: String? {
        self.identifier?.rawValue
    }

}
