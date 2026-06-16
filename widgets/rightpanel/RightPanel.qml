import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../theme"
import "../common"

PanelWindow {
    id: root

    property bool opened: false
    property bool focus: opened ? true : false

    width: 420
    color: "transparent"
    focusable: true
    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.layer: WlrLayer.Top

    anchors {
        top: true
        bottom: true
        right: true
    }

    margins {
        right: opened ? 16 : -width
        top: 64
        bottom: 28
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: Theme.borderRadius * 2
        border.width: 1
        border.color: Theme.textMuted
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 15

        Row {
            width: parent.width
            spacing: 15
            leftPadding: 24

            PanelTab {
                tabText: "󰌹 Links"
                tabSelected: true
            }
            PanelTab {
                tabText: "󰉋 Files"
            }
            PanelTab {
                tabText: "󰭻 Chat"
            }
        }

        AlbumsDropdown {}


        HyprlandFocusGrab {
            id: grab

            windows: [root, linkInput.control]
        }

        LinkInputBox {
            id: linkInput
            control.focus: root.focus
        }
        


    }

    Behavior on margins.right {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }

    }

}
