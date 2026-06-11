import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../theme"

PanelWindow {
    id: leftPanel
    property bool opened: false
    
    // MarginWrapperManager { margin: 5 }

    anchors {
        top: true
        bottom: true
        left: true
    }
    width: 300
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    margins {
        top: 40
        left: opened ? 8: -width
        bottom: 8
    }

    Behavior on margins.left {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: 0
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

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
