# Quickshell Project Guidelines

This project uses **Quickshell**, a desktop shell creation toolkit based on Qt6 and QtQuick.

## Core Technology Stack
- **Framework:** Quickshell (QtQuick/QML under the hood)
- **Imports:** Uses `import Quickshell`, `import Quickshell.Wayland`, `import Quickshell.Hyprland`, etc.
- **Components:** Built using Quickshell-specific types (e.g., `PanelWindow`, `WlrLayershell`, `HyprlandFocusGrab`) combined with standard QtQuick primitives.

## Important Notes for Agents
1. **Testing:** This is a Quickshell configuration. Standard `qml` or `qmlscene` test commands might fail to load Quickshell-specific imports if they are not system-installed Qt modules. Assume Quickshell is the runner. Use `qs -p $HOME/.config/quickshell/mi-shell`
2. **File Structure:**
   - Widgets are organized by screen area/purpose (e.g., `widgets/rightpanel/`).
   - Reusable components are in `widgets/common/`.
   - Theming is handled via custom QML components/singletons in `theme/`.
3. **Execution:** This is an active shell environment overlay. Changes directly impact the user's desktop experience.

When adding new features or components, always prioritize matching the existing Quickshell structure over generic QML desktop application patterns.

4. **File System Access:** Qt's native `FolderListModel` is not available in the Quickshell environment. For reading directories and files, prefer using Quickshell's `Quickshell.Io.Process` combined with `Quickshell.Io.SplitParser` to execute native shell commands (like `ls`) instead of introducing external daemons or Python/Node.js backends. This keeps the configuration lightweight and native to Quickshell.
