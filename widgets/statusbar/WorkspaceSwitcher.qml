import QtQuick
import Quickshell.Hyprland

Row {
    anchors.verticalCenter: parent.verticalCenter
    spacing: 5
    
    Repeater {
        model: Hyprland.workspaces
        
        delegate: Rectangle {
            width: 34
            height: 24
            radius: 4
            color: modelData.focused ? "#7e9ece" : (modelData.active ? "#45475a" : "transparent")
            border.color: "#313244"
            border.width: 1
            
            Text {
                anchors.centerIn: parent
                text: modelData.id
                color: modelData.focused ? "#11111b" : "#cdd6f4"
                font.bold: modelData.focused
                font.pixelSize: 14
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.activate()
            }
        }
    }
}
