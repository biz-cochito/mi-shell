import QtQuick
import Quickshell
import "../../"
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

Rectangle {
    id: root

    property real previewHeight: 320
    property string fileName: "Hover file to preview"
    property string fullPath: ""
    property string thumbSrc: ""
    property bool isDir: false
    property bool isVideo: false
    property bool isAudio: false
    property bool isImage: false

    implicitHeight: previewHeight
    color: Theme.surface
    border.color: Theme.border
    // border.width: 1
    radius: Theme.borderRadius
    clip: true

    ColumnLayout {
        id: previewBoxContent
        anchors.fill: parent
        spacing: 4

        ClippingWrapperRectangle {
            radius: Theme.borderRadius
            Layout.fillWidth: true
            Layout.fillHeight: true
            // anchors.fill: parent
            height: root.previewHeight
            margin: 4
            color: "transparent"
            clip: true
        }
        Image {
            id: thumbImage
            source: root.thumbSrc
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 8
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: fileInfo
            implicitHeight: previewBoxContent * 0.25
        }
        ThemeText {
            id: fileNameText
            text: root.fileName
            font.pixelSize: 12
            Layout.fillWidth: true
            Layout.margins: 4
            // horizontalAlignment: Text.AlignHCenter
            // verticalAlignment: Text.AlignVCenter
            anchors.centerIn: previewBoxContent
            elide: Text.ElideRight
        }
    }
}
