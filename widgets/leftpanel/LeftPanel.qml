import "../../theme"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    id: root

    property bool opened: false

    height: 935
    width: 360
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Top

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
        left: opened ? 0 : -width
        top: 26
        bottom: 0
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        border.width: 1
        border.color: Theme.background

        Rectangle {
            id: panelHeader
            width: parent.width
            height: 40
            color: "transparent"

            Text {
                color: Theme.accent
                text: "mishell"
                font.pixelSize: 20
                font.bold: true
                font.family: Theme.fontFamily
                font.italic: true
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 10
            }

        }

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: panelHeader.height
            color: "transparent"
            Column {
                anchors.fill: parent
                anchors.margins: 8
                spacing: 10

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

    }

    Behavior on margins.top {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutInBounce
        }

    }

}
