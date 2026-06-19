import "../../theme"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
// import Quickshell.Widgets

RowLayout {
    id: root

    readonly property var activeWindow: Hyprland.toplevels.values.find((t) => {
        return t.activated || t.focused;
    })

    spacing: 10
    Layout.maximumWidth: 200

    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: root.activeWindow ? "" : ""
        color: Theme.text
        font.pixelSize: 16
    }

    Text {
        id: label

        text: root.activeWindow ? root.activeWindow.title : "GNU/Linux"
        font.pixelSize: 14
        font.family: Theme.fontFamily
        color: Theme.text
        anchors.verticalCenter: parent.verticalCenter
    }

}
