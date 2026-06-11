import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 5
    
    Repeater {
        model: Hyprland.workspaces
        
        delegate: Rectangle {
            width: 28
            height: 24
            radius: 4
            color: modelData.focused ? "#89b4fa" : (modelData.active ? "#45475a" : "transparent")
            border.color: "#313244"
            border.width: 1
            
            Text {
                anchors.centerIn: parent
                text: modelData.id
                color: modelData.focused ? "#11111b" : "#cdd6f4"
                font.bold: modelData.focused
                font.pixelSize: 12
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.activate()
            }
        }
    }
}
