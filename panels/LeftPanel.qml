pragma ComponentBehavior: Bound
import QtQuick
import "../"
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    id: root

    property bool opened: false
    property int selectedTabIndex: 0

    focusable: true

    implicitHeight: Screen.height - Config.barHeight
    implicitWidth: 360
    color: Theme.accent
    exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Top


    HyprlandFocusGrab {
        id: grab

        windows: [root]
    }

    Item {
        id: escapeFocusItem
        anchors.fill: parent
        focus: root.opened

        Keys.onEscapePressed: {
            root.opened = false
        }

        Connections {
            target: root
            function onOpenedChanged() {
                if (root.opened)
                    escapeFocusItem.forceActiveFocus();
            }
        }
    }

    anchors {
        top: true
        left: true
        bottom: true
    }

    margins {
        left: opened ? 0 : -width
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

        // --- Header ---
        Rectangle {
            id: panelHeader

            width: parent.width
            height: 32
            color: "transparent"

            ThemeText {
                text: "mishell"
                color: Theme.accent
                font.pixelSize: 20
                font.bold: true
                font.italic: true
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 4
            }
        }
        // --- Tab Row ---
        Row {
            id: rowTabs

            width: parent.width
            spacing: 6
            leftPadding: 4

            TabItem {
                tabText: "󰏘 Theme"
                tabSelected: root.selectedTabIndex === 0
                onClicked: root.selectedTabIndex = 0
            }

            TabItem {
                tabText: " Settings"
                tabSelected: root.selectedTabIndex === 1
                onClicked: root.selectedTabIndex = 1
            }
        }

        // --- Tab Content ---
        Loader {
            width: parent.width
            height: parent.height - panelHeader.height - rowTabs.height - parent.spacing * 2
            sourceComponent: {
                switch (root.selectedTabIndex) {
                case 0:
                    return themeComponent;
                case 1:
                    return settingsComponent;
                default:
                    return themeComponent;
                }
            }
        }

        // --- Tab Components ---

        Component {
            id: themeComponent

            ThemeChooser {}
        }

        Component {
            id: settingsComponent

            Item {
                anchors.fill: parent

                ThemeText {
                    text: "Settings — coming soon"
                    color: Theme.textMuted
                    anchors.centerIn: parent
                    font.pixelSize: 14
                }
            }
        }
    }

    Behavior on margins.left {
        NumberAnimation {
            duration: 150
            easing.type: Easing.OutCubic
        }
    }
}
