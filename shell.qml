import QtQuick
import Quickshell
import "./widgets/statusbar"
import "./widgets/leftpanel"
import "./widgets/rightpanel"

ShellRoot {
    StatusBar { 
        id: statusBar 
        leftPanel: leftPanel
        rightPanel: rightPanel
    }
    LeftPanel { id: leftPanel }
    RightPanel { id: rightPanel }
}
