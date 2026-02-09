
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

let WINDOW_MAIN_ID = "main"
let WINDOW_MAIN_TITLE = "RWX Editor Settings"
let WINDOW_POPUP_TITLE = "RWX Editor"

let URL_PREFIX_FILE = "file://"
let URL_PREFIX_THIS_APP = "rwxEditor://"

let FINDER_EXT_DIRECTORY_URLS: Set<URL> = [
    URL(fileURLWithPath: "/")
]

let FINDER_EXT_MENU_TITLE = "RWX Editor Menu"
let FINDER_EXT_MENU_ITEMS = [
    (
        eventName: "RWXEditorFinderContextMenu",
        titleLocalized: NSLocalizedString("RWX Editor", comment: ""),
        iconName: "circle.grid.3x3"
    )
]
