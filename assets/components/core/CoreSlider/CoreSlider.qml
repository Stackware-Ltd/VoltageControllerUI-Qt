import QtQuick 2.15
import QtQuick.Controls 2.15

Slider {
    id: root
    value: 0.5

    property alias backgroundWidth: background.implicitWidth
    property alias backgroundHeight: background.implicitHeight
    property alias backgroundColor: background.color
    property alias backgroundBorder: background.border
    property alias backgroundRadius: background.radius
    property var   backgroundAddChild
    property alias backgroundHighlightedColor: backgroundHighlighted.color
    property alias backgroundHighlightedBorder: backgroundHighlighted.border

    property alias handleWidth: handle.width
    property alias handleHeight: handle.height
    property alias handleColor: handle.color
    property alias handleBorder: handle.border
    property var handleAddChild
    property alias handleRadius: handle.radius



    background: Rectangle {
        id: background

        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: root.availableWidth
        height: implicitHeight
        radius: 2
        color: "#bdbebf"

        Rectangle {
            id: backgroundHighlighted
            width: root.visualPosition * parent.width
            height: parent.height
            color: "black"
            radius: background.radius

        }
    }

    handle: Rectangle {
        id: handle

        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 13
        color: root.pressed ? "#f0f0f0" : "#f6f6f6"
        border.color: "#bdbebf"
    }

    Component.onCompleted: {
        if( backgroundAddChild)
        {
        backgroundAddChild.parent = background
        backgroundAddChild.rotation = -root.rotation

        }

        if(handleAddChild)
        {
            handleAddChild.parent = handle
            handleAddChild.rotation = -root.rotation
        }
    }
}
