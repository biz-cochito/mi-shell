//@pragma ComponentBehavior: Bound
import QtQuick
// import QtQuick.Controls.Basic
// import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../theme"
import "../common"

PanelWindow {
    id: root

    property bool opened: false
    property bool focus: opened ? true : false
    property int selectedTabIndex: 0 // 0: Links, 1: Files, 2: Chat

    width: 400
    height: 935
    color: Theme.background
    focusable: true
    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
        // bottom: true
        right: true
    }

    margins {
        right: opened ? 0 : -width
        top: 26
        bottom: 0
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: Theme.borderRadius * 2
        border.width: 1
        border.color: Theme.background
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 15

        Row {
            id: rowTabs
            width: parent.width
            spacing: 15
            leftPadding: 24

            TabItem {
                tabText: " Notes"
                tabSelected: root.selectedTabIndex === 0
                onClicked: root.selectedTabIndex = 0
            }
            TabItem {
                tabText: "󰉋 Files"
                tabSelected: root.selectedTabIndex === 1
                onClicked: root.selectedTabIndex = 1
            }
            // TabItem {
            //     tabText: "󰭻 Chat"
            //     tabSelected: root.selectedTabIndex === 2
            //     onClicked: root.selectedTabIndex = 2
            // }
        }

        Loader {
            width: parent.width
            height: parent.height - rowTabs.height - parent.spacing
            sourceComponent: root.selectedTabIndex === 1 ? filesComponent : notesComponent
        }

        Component {
            id: notesComponent
            Item {
                anchors.fill: parent

                Connections {
                    target: root
                    function onOpenedChanged() {
                        if (root.opened) {
                            notesInput.control.forceActiveFocus()
                        }
                    }
                }

                Component.onCompleted: {
                    if (root.opened) {
                        notesInput.control.forceActiveFocus()
                    }
                }

                HyprlandFocusGrab {
                    id: grab
                    windows: [root, notesInput.control]
                }

                Notepad {
                    id: notesInput
                    anchors.top: parent.top
                }
            }
        }

        Component {
            id: filesComponent
            FileManager {
                anchors.fill: parent
            }
        }
    }

    Behavior on margins.top {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }
}
