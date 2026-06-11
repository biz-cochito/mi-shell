import QtQuick
import Quickshell
import "./widgets/statusbar"
import "./widgets/leftpanel"
import "./widgets/rightpanel"

ShellRoot {
    id: shell

    StatusBar {
        id: statusBar
        leftPanel: leftPanel
        rightPanel: rightPanel
    }
    LeftPanel { id: leftPanel }
    RightPanel { id: rightPanel }

    Connections {
        target: shell
        function onBarHeightChanged() {
            statusBar.height = 32
            leftPanel.margins.top = 40
            rightPanel.margins.top = 40
        }
    }
}
