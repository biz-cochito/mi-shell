import QtQuick
import Quickshell.Hyprland
import "../../theme"

Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5

    Repeater {
        model: Hyprland.workspaces

        delegate: Rectangle {
            width: 34
            height: 24
            radius: 4
            color: modelData.focused ? Theme.accent : (modelData.active ? Theme.surfaceActive : "transparent")
            border.color: Theme.border
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: modelData.id
                color: modelData.focused ? Theme.background : Theme.text
                font.bold: modelData.focused
                font.pixelSize: 14
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.activate()
            }
        }
    }
}
