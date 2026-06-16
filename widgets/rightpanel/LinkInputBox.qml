import QtQuick
import QtQuick.Controls.Basic
import Quickshell
import "../../theme"

Rectangle {
    id: root

    property alias control: textArea
    color: Theme.surfaceActive
    width: parent.width
    height: parent.height
    radius: Theme.borderRadius * 2
    

    ScrollView {
        id: view
        anchors.fill: parent

        TextEdit {
            id: textArea
            text: activeFocus ? "" : "I do not have active focus"
            focus: rightPanel.focus
            KeyNavigation.priority: KeyNavigation.BeforeItem
            KeyNavigation.tab: textField
            color: Theme.text2

            Rectangle {
                color: "#171717"
                radius: Theme.borderRadius * 1.5
                implicitHeight: 200
                border.color: textArea.enabled ? Theme.background : "transparent"
            }

        }

    }

}
