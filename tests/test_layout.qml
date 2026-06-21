import QtQuick
import Quickshell
import "widgets/rightpanel/filemanager"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: FloatingWindow {
            required property var modelData
            screen: modelData
            implicitWidth: 300
            implicitHeight: 300
            color: "grey"
            PreviewBox {
                previewWidth: 200
                previewHeight: 250
                fileName: "SuperLongFileNameThatMightBreakTheLayout.txt"
                thumbSrc: "assets/splat1.svg"
            }
            Component.onCompleted: {
                Quickshell.app.quit()
            }
        }
    }
}
