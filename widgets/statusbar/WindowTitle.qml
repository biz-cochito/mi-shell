import QtQuick
// import Quickshell
import Quickshell.Hyprland
import "../../theme"

Text {
    id: root

    readonly property var activeWindow: Hyprland.toplevels.values.find(t => t.activated || t.focused)

    text: activeWindow ? activeWindow.title : " GNU/Linux"
    font.pixelSize: 14
    font.family: Theme.fontFamily
    color: Theme.text
    anchors.verticalCenter: parent.verticalCenter

}
