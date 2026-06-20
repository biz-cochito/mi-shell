import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../common"
import "../../../theme"

GridView {
    id: fileGrid
    Layout.fillWidth: true
    Layout.fillHeight: true
    model: fileModel
    clip: true
    cellWidth: 100
    cellHeight: 110

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
                color: parent.containsMouse ? Theme.accentDim : "transparent"
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

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 4
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
                        sourceSize: Qt.size(80, 80)
                        
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
}
