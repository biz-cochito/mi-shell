import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../theme"

Rectangle {
    id: root
    anchors.fill: parent
    color: Theme.background
    radius: Theme.borderRadius * 2
    width: 400
    height: 300
    


    HyprlandFocusGrab {
        id: grab

        windows: [root]
    }
    ScrollView {
        id: scroll
        anchors.fill: parent
        contentWidth: textArea.width
        contentHeight: textArea.height
        clip: true
        Rectangle {
            id: view

            property alias control: textArea
            color: Theme.background
            width: parent.width
            height: parent.height
            radius: Theme.borderRadius * 2

            TextEdit {
                id: textArea
                text: activeFocus ? "" : "I do not have active focus"
                focus: rightPanel.focus
                KeyNavigation.priority: KeyNavigation.BeforeItem
                KeyNavigation.tab: textField
                color: Theme.text
                anchors.fill: view
                // height: parent.height * 0.6
                // anchors.centerIn: parent
                font.pixelSize: 14
            }
        }

        // color: "#171717"
        // radius: Theme.borderRadius * 1.5
        // implicitHeight: 200
        // border.color: textArea.enabled ? Theme.background : "transparent"
    }
}
