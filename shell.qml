//@ pragma Preload
//@ pragma DefaultEnv QS_DROP_EXPENSIVE_FONTS=1
//@ pragma DefaultEnv QSG_RENDER_LOOP=threaded
//@ pragma DefaultEnv QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000
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
                leftPanel.opened = false;
                rightPanel.opened = false;
            }
        }
    }
    LeftPanel {
        id: leftPanel
    }

    RightPanel {
        id: rightPanel
    }
    StatusBar {
        id: statusBar

        leftPanel: leftPanel
        rightPanel: rightPanel
    }

    GlobalShortcut {
        name: "toggle-right-panel"
        description: "Toggle the right panel"
        onPressed: {
            rightPanel.opened = !rightPanel.opened;
            if (rightPanel.opened) {
                Hyprland.dispatch("hl.dsp.cursor.move({ x=1300, y=500 })");
                // Hyprland.dispatch("hl.dsp.cursor.move({ x=1305, y=495 })");
            }
        }
    }

    GlobalShortcut {
        name: "toggle-left-panel"
        description: "Toggle the left panel"
        onPressed: {
            leftPanel.opened = !leftPanel.opened;

            if (leftPanel.opened) {
                Hyprland.dispatch("hl.dsp.cursor.move({ x=200, y=500 })");
            }
        }
    }

    GlobalShortcut {
        name: "close-panels"
        description: "Close any open panels"
        onPressed: {
            leftPanel.opened = false;
            rightPanel.opened = false;
        }
    }
}
