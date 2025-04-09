import QtQuick
import QtQuick.Controls.Universal

TextField {
    id: root
    width: 200
    height: 40
    leftPadding: 15
    color: root.focus === true ? root.textColorSelected : root.textColor

    property string placeholder: "Placeholder"

    property int borderRadius: width * 0.03
    property int borderWidth: resp.avg(3)

    property color fillColor: "gray"
    property color textColor: "gray"
    property color textColorSelected: root.color
    property color borderColor: "gray"
    property color borderColorSelected: root.borderColor

    background: Rectangle {
        id: backgroudVisual
        color: root.fillColor
        border.width: root.borderWidth
        border.color: root.focus === true ? root.borderColorSelected : root.borderColor
        radius: root.borderRadius

        Label {
            id: floatingPlaceholder
            color: root.text.length !== 0 ? backgroudVisual.border.color : root.placeholderTextColor
            text: root.placeholder
            font.pixelSize: root.font.pixelSize
            font.family: "Roboto"
            font.weight: Font.Normal

            background: Rectangle {
                id: borderHider
                width: parent.width * 1.12
                height: parent.height
                color: root.fillColor
                radius: width * 0.05
                opacity: 0

                anchors.centerIn: parent
            }

            anchors.verticalCenter: backgroudVisual.verticalCenter
            anchors.left: backgroudVisual.left
            anchors.leftMargin: root.leftPadding

            states: [
                State {
                    name: "float"
                    when: root.text.length !== 0

                    PropertyChanges {
                        target: floatingPlaceholder
                        font.pixelSize: root.font.pixelSize * 0.75
                    }

                    PropertyChanges {
                        target: borderHider
                        opacity: 1
                    }

                    PropertyChanges {
                        target: floatingPlaceholder
                        anchors.leftMargin: root.leftPadding
                        anchors.verticalCenter: parent.top

                    }
                }
            ]

            transitions: [
                Transition {
                    to: "float"

                    ParallelAnimation {

                        NumberAnimation {
                            target: borderHider
                            property: "opacity"
                            duration: 100
                        }

                        NumberAnimation {
                            target: floatingPlaceholder
                            property: "font.pixelSize"
                            duration: 100
                        }
                        // NumberAnimation {
                        //     target: floatingPlaceholder
                        //     property: "y"
                        //     duration: 250
                        // }
                        // NumberAnimation {
                        //     target: floatingPlaceholder;
                        //     property: "x";
                        //     duration: 250;
                        // }
                    }
                },

                Transition {
                    from: "float"

                    ParallelAnimation {

                        NumberAnimation {
                            target: borderHider
                            property: "opacity"
                            duration: 100
                        }
                        NumberAnimation {
                            target: floatingPlaceholder
                            property: "font.pixelSize"
                            duration: 100
                        }
                        // NumberAnimation {
                        //     target: floatingPlaceholder
                        //     property: "y"
                        //     duration: 250
                        // }
                        // NumberAnimation {
                        //     target: floatingPlaceholder
                        //     property: "x"
                        //     duration: 250
                        // }
                    }
                }
            ]
        }
    }
}
