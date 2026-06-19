import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../theme"

PanelWindow {
    id: root
    property bool opened: false

    height: 800
    width:380
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    HyprlandFocusGrab {
        id: grab

        windows: [root]
    }

    anchors {
        top: true
        // bottom: true
        left: true
    }

    margins {
        left: 20
        top: opened ? 86 : -height
        bottom: 20
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: Theme.borderRadius * 2
        border.width: 1
        border.color: Theme.border

        RowLayout {
            implicitHeight: 40

            Text {
                color: Theme.accent
                text: "Left"
                font.pixelSize: 20
                font.bold: true

            }

        }

        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Rectangle {
                width: parent.width - 40
                height: 1
                color: Theme.text
            }

            Text {
                text: "Settings"
                color: Theme.text
            }

            Text {
                text: "Configuration"
                color: Theme.text
            }

            Text {
                text: "Hyprland Toggles"
                color: Theme.text
            }

        }

    }

    Behavior on margins.top {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutInBounce
        }

    }

}
