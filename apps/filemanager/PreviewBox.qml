import QtQuick
import Quickshell
import "../../"
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root

    property int previewHeight: 215
    property int previewWidth: 200
    property string fileName: "Hover file to preview"
    property string fullPath: ""
    property string thumbSrc: ""
    property bool isDir: false
    property bool isVideo: false
    property bool isAudio: false
    property bool isImage: false

    implicitHeight: previewHeight
    color: Theme.background
    border.color: Theme.border
    border.width: 1
    radius: Theme.borderRadius
    clip: true

    ColumnLayout {
        anchors.fill: parent
        spacing: 4

        ThemeText {
            id: fileNameText
            text: root.fileName
            Layout.fillWidth: true
            Layout.margins: 4
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        Image {
            id: thumbImage
            source: root.thumbSrc
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 4
            fillMode: Image.PreserveAspectFit
        }
    }
}
