
# Privacy Policy

The source code of the application is open and available in the repository
for review and analysis at "https://github.com/maxrys/rwx-editor".


## Application structure

The application is a bundle of two parts:
- main application `RWX Editor`;
- Finder extension `RWX Editor Extension`.

The main application consists of:
- the main `RWX Editor | Settings` window (in it, the user determines which
  directories will be available to the `RWX Editor Extension` for working with
  files/directories via the Finder context menu);
- dynamic `RWX Editor` windows that will be created in the context of each
  file/directory (after clicking on the `RWX Editor` item
  in the Finder context menu).

Finder extension displays an additional `RWX Editor` menu item
in the Finder context menu.  
Clicking on this menu item launches the main application and dynamically
creates the `RWX Editor` window in the context of this file/directory.

The Finder extension can only be launched after the user has enabled
the corresponding switch in the system settings.


## Modifying the file system

The application changes POSIX permissions on files and directories
at the user's request within the capabilities of this application.

Changing permissions outside of allowed directories is not available.

Changing permissions on files and directories that do not belong
to the user is not available.


## Data storage

The application uses the standard `Core Data` mechanism to store
the "bookmarks list" in the local database.


## Other activities

Application:
- runs in an isolated OS environment (sandbox);
- does not register user clicks;
- does not have access to the clipboard;
- does not send or receive data over the network;
- does not collect or store personal data;
- does not transfer data to third parties.
