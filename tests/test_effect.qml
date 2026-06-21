import QtQuick
import QtQuick.Effects
import "theme"

Item {
    id: root

    width: 100
    height: 100

    Image {
        id: img

        source: "assets/splat1.svg"
        sourceSize: Qt.size(parent.width, parent.height)
        visible: false
    }

    MultiEffect {
        source: img
        anchors.fill: img
        colorization: 1.0
        colorizationColor: Theme.accent
    }

}
