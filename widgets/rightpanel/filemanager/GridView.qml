pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "../../common"
import "../../../theme"

GridView {
    id: fileGrid
    Layout.fillWidth: true
    Layout.fillHeight: true
    model: fileModel
    clip: true
    cellWidth: 125
    cellHeight: 125

    delegate: Item {
        width: fileGrid.cellWidth
        height: fileGrid.cellHeight

        required property string name
        required property bool isDir

        property string fullPath: root.currentPath + (root.currentPath === "/" ? "" : "/") + name
        property string fileUri: "file://" + fullPath
        property string md5Hash: Qt.md5(fileUri)
        property string normalThumb: Quickshell.env("HOME") + "/.cache/thumbnails/normal/" + md5Hash + ".png"
        property string ext: name.split('.').pop().toLowerCase()
        property bool isImage: ["png", "jpg", "jpeg", "webp", "gif", "svg"].includes(ext)
        property bool isVideo: ["mp4", "mkv", "webm", "avi", "mov"].includes(ext)
        property bool isAudio: ["mp3", "wav", "ogg", "flac"].includes(ext)

        MouseArea {
            id: ma
            anchors.fill: parent
            anchors.margins: 4
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            Rectangle {
                anchors.fill: parent
                color: parent.containsMouse ? Theme.border : "transparent"
                radius: 6
            }

            onClicked: {
                if (isDir) {
                    root.currentPath = fullPath;
                } else {
                    openProcess.command = ["xdg-open", fullPath];
                    openProcess.running = true;
                }
            }

            onContainsMouseChanged: {
                if (!containsMouse && previewPopup.anchor.item === ma) {
                    previewPopup.visible = false
                }
            }

            Timer {
                id: hoverTimer
                interval: 350
                running: ma.containsMouse
                onTriggered: {
                    if (ma.containsMouse) {
                        previewPopup.fileName = name
                        previewPopup.fullPath = fullPath
                        previewPopup.thumbSrc = thumbImage.source
                        previewPopup.isDir = isDir
                        previewPopup.isVideo = isVideo
                        previewPopup.isAudio = isAudio
                        previewPopup.isImage = isImage
                        previewPopup.anchor.item = ma
                        previewPopup.visible = true
                    }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 2
                spacing: 4

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Image {
                        id: thumbImage
                        anchors.fill: parent
                        source: "file://" + normalThumb
                        fillMode: Image.PreserveAspectFit
                        asynchronous: true
                        sourceSize: Qt.size(100, 100)

                        onStatusChanged: {
                            if (status === Image.Error && isImage) {
                                source = fileUri
                            }
                        }
                    }

                    ThemeText {
                        anchors.centerIn: parent
                        text: isDir ? "󰉋" : (isVideo ? "󰕧" : (isAudio ? "󰎆" : "󰈔"))
                        font.pixelSize: 40
                        color: isDir ? Theme.accent : Theme.textMuted
                        visible: thumbImage.status !== Image.Ready
                    }
                }

                ThemeText {
                    text: name
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    elide: Text.ElideRight
                    font.pixelSize: 12
                }
            }
        }
    }

    PopupWindow {
        id: previewPopup
        visible: false
        grabFocus: false

        property string fileName: ""
        property string fullPath: ""
        property string thumbSrc: ""
        property bool isDir: false
        property bool isVideo: false
        property bool isAudio: false
        property bool isImage: false

        anchor.edges: Edges.Left
        anchor.gravity: Edges.Right

        width: 300
        height: 350
        color: "transparent"

        Rectangle {
            anchors.fill: parent
            color: Theme.surface
            border.color: Theme.border
            border.width: 1
            radius: Theme.borderRadius

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 5
                spacing: 5

                Item {
                    Layout.preferredWidth: 290
                    Layout.preferredHeight: 290

                    Image {
                        id: popupThumb
                        anchors.fill: parent
                        source: previewPopup.thumbSrc
                        fillMode: Image.PreserveAspectFit
                        asynchronous: true
                        sourceSize: Qt.size(200, 200)
                    }

                    ThemeText {
                        anchors.centerIn: parent
                        text: previewPopup.isDir ? "󰉋" : (previewPopup.isVideo ? "󰕧" : (previewPopup.isAudio ? "󰎆" : "󰈔"))
                        font.pixelSize: 60
                        color: previewPopup.isDir ? Theme.accent : Theme.textMuted
                        visible: popupThumb.status !== Image.Ready
                    }
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 5

                    ThemeText {
                        text: previewPopup.fileName
                        font.bold: true
                        font.pixelSize: 16
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        maximumLineCount: 3
                        elide: Text.ElideRight
                    }

                    ThemeText {
                        text: previewPopup.isDir ? "Directory" : (previewPopup.isImage ? "Image File" : (previewPopup.isVideo ? "Video File" : (previewPopup.isAudio ? "Audio File" : "File")))
                        font.pixelSize: 14
                        color: Theme.accent
                    }

                    ThemeText {
                        text: previewPopup.fullPath
                        font.pixelSize: 12
                        color: Theme.textMuted
                        Layout.fillWidth: true
                        wrapMode: Text.WrapAnywhere
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }

                    Item { Layout.fillHeight: true }
                }
            }
        }
    }
}
