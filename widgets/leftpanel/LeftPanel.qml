import QtQuick
import Quickshell
import "../../theme"

PanelWindow {
    id: leftPanel
    property bool opened: false

    anchors {
        top: true
        bottom: true
        left: true
    }
    width: 300
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    margins {
        top: barHeight + (barHeight / 2)
        left: opened ? barHeight: -width
        bottom: barHeight / 2
    }

    Behavior on margins.left {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: 12
    }

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Left Panel"
            color: Theme.accent
            font.pixelSize: 20
            font.bold: true
        }

        Rectangle {
            width: parent.width - 40
            height: 1
            color: Theme.border
        }

        Text { text: "Settings"; color: Theme.text }
        Text { text: "Configuration"; color: Theme.text }
        Text { text: "Hyprland Toggles"; color: Theme.text }
    }
}
