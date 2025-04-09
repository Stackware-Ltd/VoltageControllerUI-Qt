import QtQuick
import QtQuick.Controls.Universal
import Qt5Compat.GraphicalEffects

Button {
    id: root
    implicitWidth: 50
    implicitHeight: 40

    property string srcPressed: "./ComponentAssets/push_button_pressed.png"
    property string srcUnpressed: "./ComponentAssets/push_button_unpressed.png"

    property int  radius: 0
    property bool isDefault: false

    background: Rectangle{
        id: mainbackground
        color: "transparent"
        anchors.fill: parent
        radius: root.radius

        Image {
            id: icon
            visible: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            sourceSize: Qt.size(root.width, root.height)
            layer.enabled: true
            layer.effect: OpacityMask
            {
                maskSource: Rectangle { width: mainbackground.width; height: mainbackground.height ; radius: root.radius}
            }
        }

        HoverHandler {
            acceptedDevices: PointerDevice.AllDevices
            cursorShape: Qt.PointingHandCursor
        }

        Component.onCompleted:
        {
            root.isDefault = true
        }
    }


    states: [
        State {
            name: "pressedState"
            when: isDefault && root.pressed
            PropertyChanges { target: icon; source: srcPressed}
        },
        State {
            name: "unpressedState"
            when: isDefault && !root.pressed
            PropertyChanges { target: icon; source: srcUnpressed}
        }
    ]
}
