pragma ComponentBehavior: Bound
import QtQuick
import "../../"
import QtQuick.Layouts
import Quickshell

ListView {
    id: fileList
    Layout.fillWidth: true
    Layout.fillHeight: true
    model: fileModel
    clip: true

    delegate: Item {
        id: delegateRoot
        width: fileList.width
        height: 30

        required property string name
        required property bool isDir

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            Rectangle {
                anchors.fill: parent
                color: parent.containsMouse ? Theme.border : "transparent"
                radius: Theme.borderRadius
            }

            onClicked: {
                let sep = root.currentPath === "/" ? "" : "/";
                let fullPath = root.currentPath + sep + delegateRoot.name;
                if (delegateRoot.isDir) {
                    root.currentPath = fullPath;
                } else {
                    openProcess.command = ["xdg-open", fullPath];
                    openProcess.running = true;
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    spacing: 10

                    ThemeText {
                        text: delegateRoot.isDir ? "󰉋" : "󰈔"
                        color: delegateRoot.isDir ? Theme.accent : Theme.textMuted
                    }

                    ThemeText {
                        text: delegateRoot.name
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
