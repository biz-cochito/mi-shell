import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import "../"

// Rectangle {

//     height: Config.barHeight - (Theme.fontSize * 0.5)
//     width: 110
//     radius: 2
//
//     color: Theme.surface

FlexboxLayout {
    id: root
    // border.width: 1
    // border.color: isCharging ? Theme.success : Theme.border
    property real percentage: 0
    property int batteryState: 0
    property bool isCharging: false
    property int blockWidth: 10
    // anchors.verticalCenter: parent.verticalCenter
    direction: FlexboxLayout.Row
    justifyContent: FlexboxLayout.JustifyStart
    alignContent: FlexboxLayout.AlignStart
    alignItems: FlexboxLayout.AlignStretch
    gap: 4
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.margins: 4

    Rectangle {
        id: block1
        implicitWidth: root.blockWidth
        implicitHeight: 24
        radius: 2
    }
    Rectangle {
        id: block2
        implicitWidth: root.blockWidth
        implicitHeight: 24
        radius: 2
    }
    Rectangle {
        id: block3
        implicitWidth: root.blockWidth
        implicitHeight: 24
        radius: 2
    }
    Rectangle {
        id: block4
        implicitWidth: root.blockWidth
        implicitHeight: 24
        radius: 2
    }
    Rectangle {
        id: block5
        implicitWidth: root.blockWidth
        implicitHeight: 24
        radius: 2
    }        // Repeater {
    //     model: 5
    //     delegate: Rectangle {
    //         // > 0% -> first block active
    //         // > 20% -> second block active
    //         // > 40% -> third block active
    //         // > 60% -> fourth block active
    //         // > 80% -> fifth block active
    //         property bool active: root.percentage > (index * 20)
    //         implicitWidth: 15
    //         implicitHeight: 24
    //         radius: 2

    //         color: {
    //             if (active) {
    //                 if (root.isCharging)
    //                     return Theme.success;
    //                 if (root.percentage <= 20)
    //                     return Theme.error;
    //                 return Theme.accent;
    //             }
    //             return Theme.background;
    //         }

    //         Behavior on color {
    //             ColorAnimation {
    //                 duration: 200
    //             }
    //         }
    //     }
    // }
}
// }
