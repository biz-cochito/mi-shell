import QtQuick
import Quickshell

PanelWindow {
    id: leftPanel
    property bool opened: false

    anchors {
        top: true
        bottom: true
        left: true
    }
    width: 300
    color: "#181825"
    
    exclusionMode: ExclusionMode.None
    
    margins {
        left: opened ? 0 : -width
    }

    Behavior on margins.left {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }
    
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20
        
        Text { 
            text: "Left Panel"
            color: "#89b4fa"
            font.pixelSize: 20
            font.bold: true
        }
        
        Rectangle {
            width: parent.width - 40
            height: 1
            color: "#313244"
        }

        Text { text: "Settings"; color: "#cdd6f4" }
        Text { text: "Configuration"; color: "#cdd6f4" }
        Text { text: "Hyprland Toggles"; color: "#cdd6f4" }
    }
}
