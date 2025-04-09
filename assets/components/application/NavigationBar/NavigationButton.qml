import QtQuick
import QtQuick.Controls.Universal

Rectangle {
    id: root
    implicitWidth: 60
    implicitHeight: 40
    color: "transparent"

    property bool isOn: false

    property string iconOn: ""
    property string iconOff: ""
    property int iconSize: 16

    property string highlightColor: "#004F53"
    property int highlightRadius: width/2

    property string label: "label"
    property int labelSize: 12
    property bool labelVisible: true
    property string labelColorOn: "white"
    property string labelColorOff: "white"

    property alias mouseArea: btnMouseArea

    Rectangle {
        id: highlightBox
        anchors.fill: parent
        radius: highlightRadius
        color: highlightColor
        visible: true
    }

    Image {
        id: icon
        width: iconSize
        sourceSize: Qt.size(iconSize, iconSize)
        fillMode: Image.PreserveAspectFit

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: resp.avg(18)
    }

    Label {
        id: buttonLabel
        visible: labelVisible
        text: label
        font.family: theme.primaryFont
        font.pixelSize: labelSize
        font.weight: Font.DemiBold

        anchors.verticalCenter: icon.verticalCenter
        anchors.left: icon.right
        anchors.leftMargin: resp.avg(40)
    }

    MouseArea {
        id: btnMouseArea
        width: root.width
        height: root.height
    }

    states: [
        State {
            name: "onState"
            PropertyChanges { target: icon; source: iconOn}
            PropertyChanges { target: highlightBox; visible: true}
            PropertyChanges { target: buttonLabel; color: labelColorOn}
        },
        State {
            name: "offState"
            PropertyChanges { target: icon; source: iconOff}
            PropertyChanges { target: highlightBox; visible: false}
            PropertyChanges { target: buttonLabel; color: labelColorOff}
        }
    ]

    state: isOn ? "onState" : "offState"
}
