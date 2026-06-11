import QtQuick
import Quickshell

PanelWindow {
    id: rightPanel
    property bool opened: false

    anchors {
        top: true
        bottom: true
        right: true
    }
    width: 350
    color: "#181825"
    
    exclusionMode: ExclusionMode.None
    
    margins {
        right: opened ? 0 : -width
    }

    Behavior on margins.right {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }
    
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10
        
        Row {
            width: parent.width
            spacing: 20
            
            Text { 
                text: "󰭻 Chat"
                color: "#89b4fa"
                font.bold: true
            }
            Text { text: "󰉋 Files"; color: "#cdd6f4" }
            Text { text: "󰃭 Bookmarks"; color: "#cdd6f4" }
        }

        Rectangle {
            width: parent.width - 40
            height: 1
            color: "#313244"
        }

        Rectangle {
            width: parent.width - 40
            height: parent.height - 100
            color: "#1e1e2e"
            radius: 10
            
            Text {
                anchors.centerIn: parent
                text: "LLM Chat Placeholder"
                color: "#585b70"
            }
        }
    }
}
