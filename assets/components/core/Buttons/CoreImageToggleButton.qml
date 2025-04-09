import QtQuick
import QtQuick.Controls.Universal
import Qt5Compat.GraphicalEffects

Button {
    id: root
    implicitWidth: 50
    implicitHeight: 40
    checkable: true

    property string srcOffState: "./button_assets/button_unpressed.svg"
    property string srcOnState: "./button_assets/button_pressed.svg"
    property string srcOnPressedState: "./button_assets/button_pressed_hold.svg"
    property string srcOffPressedState: "./button_assets/button_unpressed_hold.svg"

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
            name: "offState"
            when: !root.pressed && !root.checked && isDefault
            PropertyChanges { target: icon; source: srcOffState}
        },
        State {
            name: "offPressedState"
            when: root.pressed && !root.checked && isDefault
            PropertyChanges { target: icon; source: srcOffPressedState}
        },
        State {
            name: "onState"
            when: !root.pressed && root.checked && isDefault
            PropertyChanges { target: icon; source: srcOnState}
        },
        State {
            name: "onPressedState"
            when: root.pressed && root.checked && isDefault
            PropertyChanges { target: icon; source: srcOnPressedState }
        }
    ]
}
