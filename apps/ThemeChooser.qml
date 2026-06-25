pragma ComponentBehavior: Bound
import QtQuick
import "../"
import Quickshell



Item {
    id: root

    anchors.fill: parent

    // Get sorted palette names once, stored as a plain JS array.
    // Object.keys() on a QML `var` object works fine here.
    property var themeNames: Object.keys(Theme.palettes).sort()

    Flickable {
        id: themeList

        anchors.fill: parent
        contentHeight: themeColumn.height
        clip: true

        Column {
            id: themeColumn

            width: parent.width
            spacing: 6

            Repeater {
                model: root.themeNames

                delegate: Rectangle {
                    id: themeCard

                    required property string modelData

                    // Convenience alias for this palette's color map
                    property var pal: Theme.palettes[modelData]
                    property bool isActive: Theme.activeTheme === modelData

                    width: themeColumn.width
                    height: 58
                    radius: Theme.borderRadius
                    color: isActive ? Qt.rgba(Theme.accent.r, Theme.accent.g, Theme.accent.b, 0.15)
                                    : mouseArea.containsMouse ? Theme.surface
                                                              : "transparent"
                    border.width: isActive ? 1 : 0
                    border.color: Theme.accent

                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Theme.activeTheme = themeCard.modelData
                    }

                    Row {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 12

                        // --- Left side: theme name + active indicator ---
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.35
                            spacing: 4

                            ThemeText {
                                text: themeCard.modelData
                                font.pixelSize: 14
                                font.bold: themeCard.isActive
                                color: themeCard.isActive ? Theme.accent : Theme.text
                            }

                            ThemeText {
                                text: themeCard.isActive ? "● Active" : ""
                                font.pixelSize: 11
                                color: Theme.active
                            }
                        }

                        // --- Right side: color swatch strip ---
                        // Shows the 6 most visually distinctive palette colors
                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 4

                            Repeater {
                                // Key colors: bg, surface, accent, accentDim, active, error
                                model: [
                                    themeCard.pal.background,
                                    themeCard.pal.surface,
                                    themeCard.pal.accent,
                                    themeCard.pal.accentDim,
                                    themeCard.pal.active,
                                    themeCard.pal.error
                                ]

                                delegate: Rectangle {
                                    required property var modelData

                                    width: 28
                                    height: 28
                                    radius: 14 // circle
                                    color: modelData
                                    border.width: 1
                                    border.color: Qt.rgba(1, 1, 1, 0.12)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
