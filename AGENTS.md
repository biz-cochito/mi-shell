# mishell Project

This project uses **Quickshell**, a toolkit based on Qt6 and QtQuick, to build a desktop shell for Hyprland.

## Core Technology Stack
   - **Framework:** Quickshell (QtQuick/QML under the hood)
   - **Imports:** Uses `import Quickshell`, `import Quickshell.Wayland`, `import Quickshell.Hyprland`, etc.
   - **Components:** Built using Quickshell-specific types (e.g., `PanelWindow`, `WlrLayershell`, `HyprlandFocusGrab`) combined with standard QtQuick primitives.

## Important Notes for Agents

1. **Testing:** This is a Quickshell configuration. Standard `qml` or `qmlscene` test commands might fail to load Quickshell-specific imports if they are not system-installed Qt modules. Assume Quickshell is the runner. Use `qs -p $HOME/.config/quickshell/mi-shell`

2. **File Structure:**
   - Widgets are organized by screen area/purpose (e.g., `widgets/rightpanel/`).
   - Components that are re-used in multiple places go in `widgets/common/`.
   - Theming is handled via custom QML components/singletons in `theme/`.
   - Any "business logic" is done in Javascript. Scripts that are particular to a certain widget go in the folder of that widget, alongside the widget (e.g. `widgets/rightpanel/rightPanel.js`). Scripts that are shared across multiple widgets or the shell as a whole go in `widgets/common/`.

3. **Execution:** This is an active shell environment overlay. Changes directly impact the user's desktop experience.
   - **Testing with `qs`:** When developing locally and testing without restarting Hyprland, use the `qs` command to run the QML files: `qs -p $HOME/.config/quickshell/mi-shell`

4. **File System Access:** Qt's native `FolderListModel` is not available in the Quickshell environment. For reading directories and files, prefer using Quickshell's `Quickshell.Io.Process` combined with `Quickshell.Io.SplitParser` to execute native shell commands (like `ls`) instead of introducing external daemons or Python/Node.js backends. This keeps the configuration lightweight and native to Quickshell.

5. **Best Practices**
   - When adding new features or components, always prioritize matching the existing Quickshell structure over generic QML desktop application patterns.
