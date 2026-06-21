import QtQuick
import Quickshell
import "widgets/rightpanel"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: FloatingWindow {
            required property var modelData
            screen: modelData
            implicitWidth: 300
            implicitHeight: 300
            color: "grey"
            FileManager {
                width: 200
                height: 250
            }
        }
    }
}
