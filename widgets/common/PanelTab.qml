import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import Qt5Compat.GraphicalEffects
import "../../theme"

Item {
    // border.color: root.tabSelected ? Theme.accent : "transparent"

    id: root

    property string tabText: ""
    property bool tabSelected: false
    property int tabIndex: -1

    signal clicked()

    implicitWidth: buttonText.implicitWidth + 24
    implicitHeight: buttonText.implicitHeight + 12
    // color: root.tabSelected ? Theme.accent : "transparent"
    // radius: 30
    Image {
        id: bgSplat
        source: "../../assets/12.png"
        sourceSize: Qt.size(parent.width, parent.height)
        anchors.centerIn: parent
        width: parent.width * 1
        height: parent.height * 1
        // Allow the splat to stretch to cover the button shape
        fillMode: Image.PreserveAspectCrop
        visible: false

    }

    ColorOverlay {
        anchors.fill: bgSplat
        source: bgSplat
        color: Theme.accentDim
        visible: root.tabSelected
    }

    ThemeText {
        id: buttonText
        text: root.tabText
        // 2. Center the text in the rectangle
        anchors.centerIn: parent
        // Let's also dynamically change the text color based on selection!
        color: root.tabSelected ? Theme.text : Theme.textMuted
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
