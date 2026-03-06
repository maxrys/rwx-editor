
/* ############################################################# */
/* ### Copyright © 2025 Maxim Rysevets. All rights reserved. ### */
/* ############################################################# */

import Foundation

let APP_GROUP_NAME = "group.maxrys.rwx-editor"
let WINDOW_MAIN_ID = "main"
let WINDOW_MAIN_TITLE  = NSLocalizedString("RWX Editor | Settings", comment: "")
let WINDOW_POPUP_TITLE = NSLocalizedString("RWX Editor", comment: "")

let NOT_APPLICABLE = "—"
let URL_PREFIX_FILE = "file://"
let URL_PREFIX_THIS_APP = "rwxEditor://"
let URL_SUFFIX_FOR_DIR = "/"

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
