import QtQuick
import Qt5Compat.GraphicalEffects
import "../global"

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

    ColorOverlay {
        anchors.fill: img
        source: img
        color: Theme.accent
    }

}
