
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import SwiftUI

extension NSWindow {

    static var customWindows: [
        String: NSWindow
    ] = [:]

    static func makeAndShowFromSwiftUIView(
        ID: String,
        title: String,
        styleMask: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable],
        level: NSWindow.Level = .normal,
        isVisible: Bool = true,
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
            contentRect: NSRect(x: 0, y: 0, width: 1000, height: 1000),
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

        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.leadingAnchor .constraint(equalTo: window.contentView!.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: window.contentView!.trailingAnchor),
            hostingView.topAnchor     .constraint(equalTo: window.contentView!.topAnchor),
            hostingView.bottomAnchor  .constraint(equalTo: window.contentView!.bottomAnchor),
        ])

        return true
    }

    static func show(_ ID: String) { self.customWindows[ID]?.makeKeyAndOrderFront(nil) }
    static func hide(_ ID: String) { self.customWindows[ID]?.orderOut(nil) }

    func show() { self.makeKeyAndOrderFront(nil) }
    func hide() { self.orderOut(nil) }

    var ID: String? {
        self.identifier?.rawValue
    }

}
