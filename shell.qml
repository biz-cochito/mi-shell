import QtQuick
import Quickshell
import "./widgets/statusbar"
import "./widgets/leftpanel"
import "./widgets/rightpanel"

ShellRoot {
    id: shell
    property int barHeight: 40

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
            statusBar.height = shell.barHeight
            leftPanel.margins.top = shell.barHeight + (shell.barHeight / 4)
            rightPanel.margins.top = shell.barHeight + (shell.barHeight / 4)
        }
    }
}
