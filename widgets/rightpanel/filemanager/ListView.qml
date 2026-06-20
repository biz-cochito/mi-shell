import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../common"
import "../../../theme"

ListView {
            id: fileList
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: fileModel
            clip: true

            delegate: Item {
                width: ListView.view.width
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
                        radius: 4
                    }
                    
                    onClicked: {
                        let sep = root.currentPath === "/" ? "" : "/";
                        let fullPath = root.currentPath + sep + name;
                        if (isDir) {
                            root.currentPath = fullPath;
                        } else {
                            openProcess.command = ["xdg-open", fullPath];
                            openProcess.running = true;
                        }
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    anchors.rightMargin: 5
                    spacing: 10

                    ThemeText {
                        text: isDir ? "󰉋" : "󰈔"
                        color: isDir ? Theme.accent : Theme.textMuted
                    }

                    ThemeText {
                        text: name
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }
            }
        }