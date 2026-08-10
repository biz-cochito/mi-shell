import QtQuick
import Quickshell
import "../../"

FloatingWindow {
    id: root

    property int windowWidth: 400
    property int windowHeight: 300

    width: windowWidth
    height: windowHeight
    title: "Omarchy Themes"

    Rectangle {
        anchors.fill: parent
        color: Theme.active
    }
}
