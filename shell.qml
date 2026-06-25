import QtQuick
import Quickshell
import Quickshell.Hyprland

ShellRoot {
    id: root

    Item {
        id: escapeGrabber
        focus: true

        Keys.onEscapePressed: {
            if (leftPanel.opened || rightPanel.opened) {
                leftPanel.opened = false
                rightPanel.opened = false
            }
        }
    }

    StatusBar {
        id: statusBar

        leftPanel: leftPanel
        rightPanel: rightPanel
    }

    LeftPanel {
        id: leftPanel
    }

    RightPanel {
        id: rightPanel
    }

    GlobalShortcut {
        name: "toggle-right-panel"
        description: "Toggle the right panel"
        onPressed: {
            rightPanel.opened = !rightPanel.opened

            if (rightPanel.opened) {
                Hyprland.dispatch("hl.dsp.cursor.move({ x=1300, y=500 })")
                Hyprland.dispatch("hl.dsp.cursor.move({ x=1305, y=495 })")
            }

        }
    }

    GlobalShortcut {
        name: "toggle-left-panel"
        description: "Toggle the left panel"
        onPressed: {
            leftPanel.opened = !leftPanel.opened

            if (leftPanel.opened) {
                Hyprland.dispatch("hl.dsp.cursor.move({ x=200, y=500 })")
            }

        }
    }

    GlobalShortcut {
        name: "close-panels"
        description: "Close any open panels"
        onPressed: {
            leftPanel.opened = false
            rightPanel.opened = false
        }
    }

}
