import "../../theme"
import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Shapes

Item {
    // border.color: root.tabSelected ? Theme.accent : "transparent"
    // color: root.tabSelected ? Theme.accent : "transparent"
    // radius: 30

    id: root

    property string tabText: ""
    property bool tabSelected: false
    property int tabIndex: -1

    signal clicked()

    implicitWidth: buttonText.implicitWidth * 1.5
    implicitHeight: buttonText.implicitHeight * 2

    Rectangle {
        id: tabItem
        anchors.fill: parent
        color: root.tabSelected ? Theme.accent : mouseArea.containsMouse ? Theme.surface : "transparent"
        radius: Theme.borderRadius

        ThemeText {
            id: buttonText

            text: root.tabText
            // 2. Center the text in the rectangle
            anchors.centerIn: parent
            // Let's also dynamically change the text color based on selection!
            color: root.tabSelected ? Theme.textActive : Theme.text
            font.bold: root.tabSelected
        }

        MouseArea {
            id: mouseArea

            // 3 & 4. Fill the whole rectangle, remove invalid color
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            // 5. Reference the correct ID to emit the signal
            onClicked: root.clicked()
        }

    }

}
