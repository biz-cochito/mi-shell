import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Io
import "../../theme"
import "../common"

Item {
    id: root

    property string currentPath: Quickshell.env("HOME") || "/"

    ListModel {
        id: fileModel
    }

    function loadDirectory() {
        fileModel.clear();
        if (root.currentPath === "") root.currentPath = "/";
        lsProcess.command = [
            "sh",
            "-c",
            "find \"$1\" -mindepth 1 -maxdepth 1 \\( -type d -o -xtype d \\) -printf '%f/\\0' | sort -z; find \"$1\" -mindepth 1 -maxdepth 1 ! \\( -type d -o -xtype d \\) -printf '%f\\0' | sort -z",
            "_",
            root.currentPath
        ];
        lsProcess.running = true;
    }

    onCurrentPathChanged: {
        loadDirectory();
    }

    Component.onCompleted: {
        loadDirectory();
    }

    Process {
        id: lsProcess
        
        stdout: SplitParser {
            splitMarker: "\u0000"
            onRead: line => {
                if (line === "") return;
                
                let isDirectory = line.endsWith("/");
                let fileName = isDirectory ? line.substring(0, line.length - 1) : line;
                
                fileModel.append({
                    name: fileName,
                    isDir: isDirectory
                });
            }
        }
    }

    Process {
        id: openProcess
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            ThemeText {
                text: "󰁍" // Back arrow icon
                font.pixelSize: 20
                visible: root.currentPath !== "/"

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        let current = root.currentPath;
                        if (current.endsWith("/") && current !== "/") {
                            current = current.slice(0, -1);
                        }
                        let parts = current.split("/");
                        parts.pop();
                        root.currentPath = parts.join("/") || "/";
                    }
                }
            }

            ThemeText {
                text: root.currentPath
                font.bold: true
                elide: Text.ElideLeft
                Layout.fillWidth: true
            }
        }

        // List
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
                        color: parent.containsMouse ? Theme.accentDim : "transparent"
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
    }
}
