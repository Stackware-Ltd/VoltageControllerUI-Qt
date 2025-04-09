import QtQuick
import QtQuick.Controls.Universal
import QtQuick.Effects

Button {
    id: root
    implicitWidth: 60
    implicitHeight: 60

    property int radius: root.width/2
    property bool elevate: true
    property string color: "#FFFFFF"
    property string colorPressed: "#FFFFFF"

    property alias image: icon
    property alias shadowEffect: buttonShadow

    background: Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: root.pressed ? root.colorPressed : root.color
        radius: root.radius
        clip: true

        Image {
            id: icon
            width: root.width * 0.6
            source: ""
            sourceSize: Qt.size(icon.width, icon.width)
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }

        HoverHandler {
            acceptedDevices: PointerDevice.AllDevices
            cursorShape: Qt.PointingHandCursor
        }
    }

    MultiEffect {
        id: buttonShadow
        anchors.fill: buttonBackground
        source: buttonBackground
        shadowEnabled: true
        autoPaddingEnabled: true
        blurMultiplier: 1
        shadowBlur: 1.0
        shadowScale: 1.0
        shadowVerticalOffset: 10
        shadowHorizontalOffset: 0
        shadowColor: "#000000"
        opacity: 0.50
        visible: root.elevate
    }
}
