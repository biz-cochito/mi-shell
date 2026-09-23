pragma Singleton
import QtQuick
import Quickshell


Singleton {
    id: root
    property int barHeight: 38
    property int barModHeight: barHeight * 0.8
    property int leftPanelWidth: 360
    property int leftPanelMargin: 8
}
