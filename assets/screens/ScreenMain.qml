import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

Item {
    id: root
    width: 480
    height: 320

    Rectangle {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 25
            spacing: 12

            RowLayout {
                Layout.fillWidth: true

                Label {
                    text: "Voltage Control Unit"
                    font.pixelSize: 20
                    font.bold: true
                    color: "white"
                    Layout.alignment: Qt.AlignLeft
                }

                Item { Layout.fillWidth: true }

                Image {
                    source: "qrc:/images/icon-info.png"
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignRight

                    MouseArea {
                        anchors.fill: parent
                        onClicked: infoPopup.open()
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 12

                Label {
                    text: "Set Your Output"
                    font.pixelSize: 14
                    color: "#cccccc"
                }

                Item { Layout.fillWidth: true }

                Switch {
                    checked: true
                    Layout.alignment: Qt.AlignRight
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                Label {
                    text: "Voltage"
                    font.pixelSize: 14
                    color: "#cccccc"
                }

                Slider {
                    id: voltageSlider
                    from: 0
                    to: 3.3
                    value: 1.5
                    stepSize: 0.1
                    Layout.fillWidth: true

                    handle: Rectangle {
                        width: 30
                        height: 30
                        radius: 15
                        color: "#007bff"
                        border.color: "#aaaaaa"
                        border.width: 5
                    }

                    onValueChanged: {
                        voltageInput.text = voltageSlider.value.toFixed(1)
                    }
                }

                RowLayout {
                    Layout.fillWidth: true

                    Label { text: "0"; color: "#aaaaaa" }
                    Item { Layout.fillWidth: true }
                    Label { text: "3.3"; color: "#aaaaaa" }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 4

                Label {
                    text: "Input"
                    font.pixelSize: 14
                    color: "#cccccc"
                }

                TextField {
                    id: voltageInput
                    placeholderText: "Input"
                    Layout.fillWidth: true
                    font.pixelSize: 14
                    text: voltageSlider.value.toFixed(1)
                }
            }

            Button {
                height: 36
                Layout.fillWidth: true

                background: Rectangle {
                    color: "#007bff"
                    radius: 6
                }

                contentItem: Text {
                    text: "Submit"
                    color: "white"
                    anchors.centerIn: parent
                    font.pixelSize: 14
                }
            }

        }

        Popup {
            id: infoPopup
            width: 300
            height: 200
            modal: true
            anchors.centerIn: parent

            Rectangle {
                width: parent.width
                height: parent.height
                color: "#333333"
                radius: 10
                border.color: "#aaaaaa"
                border.width: 1

                Text {
                    text: "Popup"
                    color: "white"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                    wrapMode: Text.WordWrap
                    anchors.margins: 10
                }
            }
        }

    }
}
