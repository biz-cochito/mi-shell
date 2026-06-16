import QtQuick
import Quickshell
import "./widgets/statusbar"
import "./widgets/leftpanel"
import "./widgets/rightpanel"

ShellRoot {
    id: root

    StatusBar {
        id: statusBar

        leftPanel: leftPanel
        rightPanel: rightPanel
    }

    LeftPanel {
        id: leftPanel
    }

    RightPanel {
        id: rightPanel
    }

    Connections {
        target: root
        function onBarHeightChanged() {
            statusBar.height = 32
            leftPanel.margins.top = 72
            rightPanel.margins.top = 72
        }
    }

}
