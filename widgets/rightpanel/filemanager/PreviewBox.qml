import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import "../../../theme"
import "../../common"

    Rectangle {
        id: previewBox

        required property int previewHeight
        required property int previewWidth
        property string fileName: "Hover file to preview"
        property string fullPath: ""
        property string thumbSrc: ""
        property bool isDir: false
        property bool isVideo: false
        property bool isAudio: false
        property bool isImage: false

        width: previewWidth
        height: previewHeight
        anchors.bottom: parent.bottom
        anchors.margins: 0
        color: Theme.background
        border.color: Theme.border
        border.width: 1
        radius: Theme.borderRadius

        ColumnLayout {
            anchors.fill: parent
            Layout.fillWidth: true
            Layout.fillHeight: true

            Image {
                id: thumbImage
                source: thumbSrc
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            ThemeText {
                id: fileNameText
                text: fileName
                Layout.fillWidth: true
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
