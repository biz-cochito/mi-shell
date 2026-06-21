import QtQuick
import Quickshell
import "widgets/rightpanel/filemanager"

ShellRoot {
    Variants {
        model: Quickshell.screens
        delegate: FloatingWindow {
            required property var modelData
            screen: modelData
            width: 300
            height: 300
            color: "transparent"
            PreviewBox {
                previewWidth: 200
                previewHeight: 250
                fileName: "SuperLongFileNameThatMightBreakTheLayout.txt"
                thumbSrc: "assets/splat1.svg"
            }
        }
    }
    Component.onCompleted: {
        Quickshell.exit(0)
    }
}
