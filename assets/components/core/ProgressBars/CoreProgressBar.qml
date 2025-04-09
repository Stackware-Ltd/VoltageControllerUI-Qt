import QtQuick
import QtQuick.Controls.Universal

ProgressBar {
    id: root
    width: 150
    height: 10

    from: 0
    to: 100
    value: 50

    property int radius: 3
    property int borderWidth: 0
    property int animationDuration: 500

    property string colorBackground: "#e6e6e6"
    property string colorProgress: "#33BC59"
    property string colorBorder: "transparent"

    property var backgroundOverlayItem
    property var progressLineOverlayItem

    background: Rectangle {
        id: backgroundOverlay
        implicitWidth: parent.width
        implicitHeight: parent.height
        color: colorBackground
        radius: root.radius
    }

    contentItem: Item {
        implicitWidth: parent.width
        implicitHeight: parent.height

        Rectangle {
            id: progressLineOverlay
            width: root.visualPosition * parent.width
            height: parent.height
            radius: root.radius
            color: colorProgress
        }
    }

    Rectangle {
        id: borderOverlay
        color: "transparent"
        radius: root.radius
        border.width: root.borderWidth
        border.color: root.colorBorder

        anchors.fill: parent
    }

    Behavior on value {
        NumberAnimation {
            duration: root.animationDuration
        }
    }

    Component.onCompleted: {
        if(backgroundOverlayItem)
            backgroundOverlayItem.parent = backgroundOverlay

        if(progressLineOverlayItem)
            progressLineOverlayItem.parent = progressLineOverlay
    }
}
