import QtQuick
import QtQuick.Controls.Basic
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

    width: 420
    color: "transparent"
    focusable: true
    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.layer: WlrLayer.Top

    anchors {
        top: true
        bottom: true
        right: true
    }

    margins {
        right: opened ? 16 : -width
        top: 64
        bottom: 28
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.background
        radius: Theme.borderRadius * 2
        border.width: 1
        border.color: Theme.textMuted
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

            PanelTab {
                tabText: "󰌹 Links"
                tabSelected: root.selectedTabIndex === 0
                onClicked: root.selectedTabIndex = 0
            }
            PanelTab {
                tabText: "󰉋 Files"
                tabSelected: root.selectedTabIndex === 1
                onClicked: root.selectedTabIndex = 1
            }
            PanelTab {
                tabText: "󰭻 Chat"
                tabSelected: root.selectedTabIndex === 2
                onClicked: root.selectedTabIndex = 2
            }
        }

        Loader {
            width: parent.width
            height: parent.height - rowTabs.height - parent.spacing
            sourceComponent: root.selectedTabIndex === 0 ? linksComponent : 
                             root.selectedTabIndex === 1 ? filesComponent : null
        }
        
        Component {
            id: linksComponent
            Item {
                anchors.fill: parent
                
                HyprlandFocusGrab {
                    id: grab
                    windows: [root, linkInput.control]
                }

                LinkInputBox {
                    id: linkInput
                    control.focus: root.focus
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
            duration: 300
            easing.type: Easing.OutCubic
        }

    }

}
