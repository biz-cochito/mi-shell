pragma Singleton
import QtQuick

QtObject {
    id: root

    property color background: Qt.rgba(0.15, 0.16, 0.22, 61)
    property color surface: "#1d1f1f"
    property color surfaceActive: "#282828"
    property color text: "#fafafa"
    property color textMuted: Qt.rgba(0.73, 0.83, 0.83, 0.5)
    property color accent: "#a570b6"
    property color accentDim: "#b899c4"
    property color active: "#00b348" 
    property color border: "#373327"
    property int borderRadius: 8
    property font fontFamily: "Maple Mono"
}
