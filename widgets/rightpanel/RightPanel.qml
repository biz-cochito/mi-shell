pragma ComponentBehavior: Bound
import "../../theme"
import "../common"
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    id: root

    property bool opened: false
    property bool focus: opened ? true : false
    property int selectedTabIndex: 0 // 0: Links, 1: Files, 2: Chat

    implicitWidth: 400
    implicitHeight: Screen.height - Config.barHeight
    color: Theme.background
    focusable: true
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Top

    anchors {
        top: true
        right: true
        bottom: true
    }

    margins {
        right: opened ? 0 : -width
        top: Config.barHeight
        bottom: 0
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 10

        Row {
            id: rowTabs

            width: parent.width
            spacing: 6
            leftPadding: 12

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
                Component.onCompleted: {
                    if (root.opened)
                        notesInput.control.forceActiveFocus();

                }
                Keys.onEscapePressed: {
                    root.opened = false;
                }

                Connections {
                    function onOpenedChanged() {
                        if (root.opened)
                            notesInput.control.forceActiveFocus();

                    }

                    target: root
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

    Behavior on margins.right {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutCubic
        }

    }

}
