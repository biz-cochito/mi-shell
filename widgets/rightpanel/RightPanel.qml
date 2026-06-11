import QtQuick
import Quickshell
import "../../theme"

PanelWindow {
    id: rightPanel
    property bool opened: false

    anchors {
        top: true
        bottom: true
        right: true
    }
    width: 320
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    margins {
        right: opened ? barHeight / 3 : -width
        top: barHeight + (barHeight / 3)
        bottom: barHeight / 3
    }

    Behavior on margins.right {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: 8
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Row {
            width: parent.width
            spacing: parent.width * 0.1

            Text {
                text: "󰭻  Chat"
                color: Theme.accent
                font.bold: true
            }
            Text { text: "󰉋  Files"; color: Theme.text }
            Text { text: "󰌹  Links"; color: Theme.text }
        }

        Rectangle {
            width: parent.width
            height: 1
            color: Theme.border
        }

        Rectangle {
            width: parent.width
            height: parent.height - 45
            color: Theme.surface
            radius: 10

            Text {
                anchors.centerIn: parent
                text: "LLM Chat Placeholder"
                color: Theme.textMuted
            }
        }
    }
}
