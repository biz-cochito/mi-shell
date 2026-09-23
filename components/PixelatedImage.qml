Image {
    id: coverArt
    anchors.fill: parent
    source: "<source>"
    fillMode: Image.PreserveAspectCrop
    visible: false
}

ShaderEffectSource {
    id: imageSource
    sourceItem: coverArt
    hideSource: true
    live: true
}

ShaderEffect {
    anchors.fill: parent

    property variant imageTexture: imageSource

    property color borderColor: Appearance.material.myOutline
    property color shadowColor: Appearance.material.myShadow
    property color targetColor: Appearance.material.myPrimary
    Behavior on targetColor {
        animation: Appearance?.animation.elementMoveFast.colorAnimation.createObject(this)
    }
    property real kuwaharaStrength: 0.67

    property real pixelSize: 2.0
    property real radius: 8
    property real borderWidth: 1.0
    property vector2d shadowOffset: Qt.vector2d(3, 3)
    property vector2d size: Qt.vector2d(width, height)

    fragmentShader: "<path>"
}
