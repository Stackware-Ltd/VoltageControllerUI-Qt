import QtQuick
import components.core

MouseArea {
    id: root
    width: resp.avg(300)
    height: resp.avg(350)
    hoverEnabled: true

    property color color: "#FFFFFF"
    property color titleColor: "#FFFFFF"
    property string icon: ""
    property string title: "Title"
    property string subtitle: "Sub Title"
    property bool completed: false
    property bool locked: false

    property real originalY: 0
    onWidthChanged: originalY = 0

    onEntered: {
        if(root.originalY == 0) {
            root.originalY = root.y
        }
        root.y = root.originalY - 20
    }

    onExited: {
        root.y = root.originalY
    }

    // Add animation on width changed
    Behavior on y {
        NumberAnimation { duration: 200; easing.type: Easing.InOutQuint }
    }

    CoreCardHolder {
        id: cardContent
        anchors.fill: parent
        radius: resp.avg(29)
        color: root.color

        Rectangle {
            id: completionState
            width: resp.avg(35)
            height: resp.avg(35)
            radius: width / 2
            color: "transparent"

            border.color: theme.colorSurface.contrastL3
            border.width: resp.avg(3)

            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: resp.avg(15)
            anchors.rightMargin: resp.avg(15)

            Image {
                width: resp.avg(35)
                sourceSize: Qt.size(cardIcon.width, cardIcon.width)
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/icon-valid.png"
                visible: root.completed

                anchors.centerIn: parent
            }
        }

        Image {
            id: cardIcon
            width: resp.avg(80)
            sourceSize: Qt.size(cardIcon.width, cardIcon.width)
            fillMode: Image.PreserveAspectFit
            source: root.icon

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: resp.avg(70)
            anchors.leftMargin: resp.avg(35)

            Text {
                id: cardTitle
                text: root.title
                color: root.titleColor
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(34)
                font.weight: Font.Bold

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.right
                anchors.leftMargin: resp.avg(10)
            }
        }

        Text {
            id: cardSubTitle
            text: root.subtitle
            color: root.titleColor
            font.family: theme.primaryFont
            font.pixelSize: resp.avg(26)
            font.weight: Font.Bold

            anchors.top: cardIcon.bottom
            anchors.left: parent.left
            anchors.topMargin: resp.avg(40)
            anchors.leftMargin: resp.avg(35)
        }

        Rectangle {
            id: lockLayer
            anchors.fill: parent
            color: "#484848"
            opacity: 0.95
            radius: parent.radius
            visible: root.locked

            Image {
                id: lockIcon
                width: resp.avg(130)
                sourceSize: Qt.size(lockIcon.width, lockIcon.width)
                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/icon-lock.png"

                anchors.centerIn: parent
            }
        }
    }
}
