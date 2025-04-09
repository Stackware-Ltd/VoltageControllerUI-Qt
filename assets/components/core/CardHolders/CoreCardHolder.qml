import QtQuick
import QtQuick.Effects

Item {
    id: root

    property int radius: 24
    property string color: "#FFFFFF"
    property alias dropshadow: cardShadow

    Rectangle {
        id: cardBackground
        width: parent.width
        height: parent.height
        color: root.color
        radius: root.radius
        clip: true
    }

    MultiEffect {
        id: cardShadow
        anchors.fill: cardBackground
        source: cardBackground
        shadowEnabled: true
        autoPaddingEnabled: true
        blurMultiplier: 1
        shadowBlur: 1.0
        shadowScale: 1.0
        shadowVerticalOffset: 6
        shadowHorizontalOffset: 6
        shadowColor: "#000000"
        opacity: 0.25
    }
}
