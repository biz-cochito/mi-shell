# File Manager Tab Design

## Overview
A simple list-based file manager for the Quickshell Right Panel. It allows users to navigate their local file system, starting from the home directory, and open files using their system default application.

## Architecture & Data Flow
- **Framework**: Quickshell QML
- **Data Source**: A standard QML `ListModel` to hold the current directory's contents.
- **Backend**: Uses `Quickshell.Io.Process` to execute `ls -1p --group-directories-first "$TARGET_DIR"`. The `-p` flag appends a `/` to directories, making it easy to distinguish files from folders during parsing.
- **Parser**: A `Quickshell.Io.SplitParser` attached to the `Process` will parse the stdout line-by-line. It will append each parsed item to the `ListModel` as an object containing `name` and `isDir` boolean.

## Components
1. **FileManager.qml**: 
   - A new QML component to be displayed in `RightPanel.qml` when the "Files" tab is selected.
   - Contains a `property string currentPath: "~"` (resolved to absolute path in implementation)
2. **Header Area**:
   - A "Up" button (visible if not at `/`) that trims the last segment from `currentPath` and re-triggers the load process.
   - A `ThemeText` label displaying the `currentPath`.
3. **List Area**:
   - `ListView` bound to the `ListModel`.
   - **Delegate**: A `RowLayout` or `Item` containing:
     - Icon (`󰉋` for folders, `󰈔` for files).
     - Text (the filename).
   - **Interaction**:
     - `MouseArea` over the delegate.
     - On click: 
       - If `isDir`: update `currentPath` to `currentPath + "/" + name`, clear `ListModel`, and restart the `ls` process.
       - If `!isDir`: spawn a separate `Quickshell.Io.Process` running `xdg-open "currentPath/name" &`.

## File Loading Process Details
- When `currentPath` changes, the `ListModel` is cleared (`clear()`).
- The `Process` `command` is set to `["sh", "-c", "ls -1p --group-directories-first \"" + currentPath + "\""]`.
- `Process.running` is set to `true`.
- The `SplitParser`'s `onRead` signal handles each line, checking if it ends with `/`. It strips the `/` and adds it to the model.

## Integration
- In `RightPanel.qml`, add a `Loader` or conditionally visible `FileManager` component that shows when the "Files" `PanelTab` is selected.

## Error Handling & Edge Cases
- Hidden files (`.`) will be shown by default if `-A` flag is used in `ls`, but for simplicity, we will omit `-A` initially so hidden files are hidden unless requested later.
- Empty directories: The model will just be empty, and the list will show nothing. A placeholder text "Folder is empty" could be added if the process finishes and the model count is 0.
