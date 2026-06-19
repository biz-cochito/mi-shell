import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io
import "../../theme"
import "utils.js" as Utils

Rectangle {
    id: root
    anchors.fill: parent
    color: Theme.background
    radius: Theme.borderRadius * 2
    width: 400
    height: 300

    property string filePath: Quickshell.env("HOME") + "/AppData/Configs/Default/Links/saved_links.txt"
    property bool isLoading: true

    HyprlandFocusGrab {
        id: grab
        windows: [root]
    }

    Process {
        id: readProcess
        command: ["sh", "-c", "touch \"$1\" && cat \"$1\"", "_", root.filePath]
        running: true
        stdout: SplitParser {
            onRead: line => {
                if (root.isLoading) {
                    if (textArea.text !== "") {
                        textArea.text += "\n" + line;
                    } else {
                        textArea.text = line;
                    }
                }
            }
        }
        onExited: {
            root.isLoading = false;
        }
    }

    Process {
        id: saveProcess
    }

    Process {
        id: exportProcess
    }

    Timer {
        id: debounceTimer
        interval: 500
        repeat: false
        onTriggered: {
            saveProcess.command = ["sh", "-c", "printf '%s' \"$1\" > \"$2\"", "_", textArea.text, root.filePath];
            saveProcess.running = true;
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Rectangle {
                Layout.fillWidth: true
                height: 30
                color: Theme.background
                border.color: nameField.activeFocus ? Theme.accent : "transparent"
                border.width: 1
                radius: Theme.borderRadius

                Rectangle {
                    anchors.fill: parent
                    color: Theme.text
                    opacity: 0.1
                    radius: Theme.borderRadius
                }

                TextInput {
                    id: nameField
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    color: Theme.text
                    font.pixelSize: 14
                    verticalAlignment: TextInput.AlignVCenter
                    clip: true
                    
                    Text {
                        text: "File name (optional)"
                        color: Theme.textMuted
                        font.pixelSize: 14
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        visible: !nameField.text && !nameField.activeFocus
                    }
                }
            }

            Rectangle {
                width: 80
                height: 30
                color: Theme.accent
                radius: Theme.borderRadius

                Text {
                    anchors.centerIn: parent
                    text: "Export"
                    color: Theme.background
                    font.pixelSize: 14
                    font.bold: true
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Utils.exportLinks(nameField, exportProcess, textArea)
                }
            }
        }

        ScrollView {
            id: scroll
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: scroll.width
            contentHeight: textArea.implicitHeight
            clip: true

            Rectangle {
                id: view

                property alias control: textArea
                color: Theme.surface
                width: scroll.width
                height: Math.max(scroll.height, textArea.implicitHeight)
                radius: Theme.borderRadius

                TextEdit {
                    id: textArea
                    focus: typeof rightPanel !== "undefined" ? rightPanel.focus : true
                    KeyNavigation.priority: KeyNavigation.BeforeItem
                    color: Theme.text
                    anchors.fill: view
                    font.pixelSize: 16
                    wrapMode: TextEdit.Wrap
                    selectByMouse: true
                    padding: 10
                    
                    onTextChanged: {
                        if (!root.isLoading) {
                            debounceTimer.restart();
                        }
                    }
                }
            }
        }
    }
}
