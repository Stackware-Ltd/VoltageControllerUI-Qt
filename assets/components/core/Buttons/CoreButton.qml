import QtQuick
import QtQuick.Controls.Universal
import QtQuick.Layouts
import QtQuick.Effects

Button {
    id: root
    implicitWidth: 100
    implicitHeight: 60

    property int radius: 15
    property bool elevate: false
    property string color: "#B3B3B3"
    property string colorPressed: "#DEDEDE"
    property real contentSpacing: 10
    property real contentMargin: 15
    property bool alignLeft: false

    property alias image: btnIcon
    property alias label: btnText

    background: Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: root.pressed ? root.colorPressed : root.color
        radius: root.radius
        clip: true

        RowLayout {
            id: containerRow
            spacing: root.contentSpacing
            anchors.fill: parent

            Image {
                id: btnIcon
                width: root.width * 0.6
                sourceSize: Qt.size(btnIcon.width, btnIcon.width)
                fillMode: Image.PreserveAspectFit
                source: ""
                visible: source != ""

                Layout.alignment: Qt.AlignRight //root.alignLeft ? Qt.AlignLeft : Qt.AlignRight
                Layout.leftMargin: root.width / root.contentMargin
            }

            Label {
                id: btnText
                text: qsTr("Button")
                font.pixelSize: root.width/6

                Layout.alignment: Qt.AlignHCenter
                Layout.rightMargin: root.alignLeft ? root.width : root.width / root.contentMargin
            }
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
        opacity: 0.3
        visible: root.elevate
    }
}
