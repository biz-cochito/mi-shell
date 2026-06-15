import QtCore
import QtQuick
import Quickshell
import QtQuick.Controls.Basic
import Quickshell.Hyprland
import "../../theme"

PanelWindow {
    id: rightPanel
    property bool opened: false
    focusable: true

    anchors {
        top: true
        bottom: true
        right: true
    }
    width: 320
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    HyprlandFocusGrab {
      id: grab
      windows: [ rightPanel ]
    }
    margins {
        right: opened ? 8 : -width
        top: 72
        bottom: 8
    }

    Behavior on margins.right {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
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

        Row {
            width: parent.width
            spacing: parent.width * 0.1

            Text {
                text: "󰭻  Chat"
                color: Theme.accent
                font.bold: true
            }
            Text {
                text: "󰉋  Files"
                color: Theme.text
            }
            Text {
                text: "󰌹  Links"
                color: Theme.text
            }
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
            radius: 0

            ScrollView {
                id: view
                anchors.fill: parent

                TextArea {
                    id: control
                    text: activeFocus ? "I have active focus!" : "I do not have active focus"
                    focus: true
                    KeyNavigation.priority: KeyNavigation.BeforeItem
                    KeyNavigation.tab: textField
                    background: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 40
                        border.color: control.enabled ? "#d1be2b" : "transparent"
                    }
                    
                }
            }
            // Text {
            //     anchors.centerIn: parent
            //     text: "LLM Chat Placeholder"
            //     color: Theme.textMuted
            // }
        }
    }
}
