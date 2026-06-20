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
    property bool showHiddenFiles: false
    property bool isGridView: false

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

    onShowHiddenFilesChanged: {
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
                
                if (!root.showHiddenFiles && fileName.startsWith(".")) return;
                
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
        anchors.margins: 2
        spacing: 0

        // Header
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

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

            ThemeText {
                text: root.showHiddenFiles ? "󰈈" : "󰈉"
                font.pixelSize: 18
                color: Theme.textMuted

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.showHiddenFiles = !root.showHiddenFiles
                }
            }

            ThemeText {
                text: root.isGridView ? "" : "󰕰"
                font.pixelSize: 18
                color: Theme.textMuted

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.isGridView = !root.isGridView
                }
            }
        }

        Loader {
            Layout.fillWidth: true
            Layout.fillHeight: true
            source: root.isGridView ? "filemanager/GridView.qml" : "filemanager/ListView.qml"
        }
    }
}
