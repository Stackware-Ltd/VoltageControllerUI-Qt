import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Universal

import components.core
import components.application
import screens

Item {
    id: root

    Rectangle {
        anchors.fill: parent

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: resp.avg(100)

            spacing: resp.avg(70)

            RowLayout {
                Layout.fillWidth: true
                spacing: resp.avg(100)
                
                Label {
                    id:voltageHeading
                    text: "Voltage Control Unit"
                    font.pixelSize: resp.avg(65)
                    font.bold: true
                    color: "black"
                }

                Item { Layout.fillWidth: true }

                Image {
                    id: infoPopUpButton
                    source: "qrc:/images/icon-info-2x.png"
                    width: resp.avg(80)
                    height: resp.avg(80)
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                       anchors.fill: parent
                       onClicked: infoPopup.open()
                   }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: resp.avg(200)

                Label {
                    id:outputLabel
                    text: "Set Your Output"
                    font.pixelSize: resp.avg(60)
                    color: "#606060"
                }

                Item { Layout.fillWidth: true }

                Switch {
                    id: outputControl
                    checked: true
                    Layout.alignment: Qt.AlignRight

                    indicator: Rectangle {
                        width: resp.avg(210)
                        height: resp.avg(90)
                        radius: height / 2
                        color: outputControl.checked ? "#0F6CBD" : "#ffffff"
                        border.color: outputControl.checked ? "#0F6CBD" : "#626262"
                        border.width: resp.avg(8)

                        Rectangle {
                            width: resp.avg(70)
                            height: resp.avg(70)
                            radius: height / 2
                            y: parent.height / 2 - height / 2
                            x: outputControl.checked ? parent.width - width - resp.avg(10) : resp.avg(10)
                            color: "white"
                            border.color: outputControl.checked ? "#0F6CBD" : "#626262"
                            border.width: resp.avg(8)
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: resp.avg(120)

                Label {
                    id:voltageLabel
                    text: "Voltage"
                    font.pixelSize: resp.avg(60)
                    color: "#606060"
                    Layout.alignment: Qt.AlignVCenter
                }

                ColumnLayout {
                    Layout.fillWidth: true

                    RowLayout {
                        Layout.fillWidth: true
                        spacing : resp.avg(70)

                        CoreActionButton {
                            id: subtractBtn
                            implicitWidth : resp.avg(80)
                            implicitHeight : resp.avg(80)
                            radius: resp.avg(25)
                            color: "#0F6CBD"
                            colorPressed: "#d0d0d0"
                            shadowEffect.opacity : 0.2

                            image.source: "qrc:/images/icon-sub-3x.png"

                            onClicked: {
                                voltageSlider.value = Math.max(voltageSlider.from, voltageSlider.value - voltageSlider.stepSize)
                            }
                        }

                        CoreSlider {
                            id: voltageSlider
                            from: 0
                            to: 3.3
                            value: 1.5
                            stepSize: 0.1
                            backgroundHeight: resp.avg(30)
                            Layout.fillWidth: true
                            backgroundColor: "#D9D9D9"
                            backgroundRadius : backgroundHeight/2

                            backgroundHighlightedColor:"#0F6CBD"

                            handleAddChild: Image {
                                source: "qrc:/images/icon-handle.png"
                                anchors.centerIn: parent
                                width: resp.avg(80)
                                height: resp.avg(80)
                                fillMode: Image.PreserveAspectFit
                            }
                            
                            onValueChanged: {
                                voltage_controller.set_voltage(voltageSlider.value.toFixed(1))
                            }

                            Label {
                                id: min
                                text: "0"
                                color: "#aaaaaa"
                                font.pixelSize: resp.avg(50)
                                anchors.right :  parent.left
                                anchors.top : parent.bottom
                                anchors.rightMargin:  - resp.avg(12)
                            }

                            Label {
                                id: max
                                text: "3.3";
                                color: "#aaaaaa"
                                font.pixelSize: resp.avg(50)
                                anchors.left :  parent.right
                                anchors.top : parent.bottom
                                anchors.leftMargin: - resp.avg(50)
                            }
                        }

                        CoreActionButton {
                            id: addBtn
                            implicitWidth : resp.avg(80)
                            implicitHeight : resp.avg(80)
                            radius: resp.avg(25)
                            color: "#0F6CBD"
                            colorPressed: "#d0d0d0"
                            shadowEffect.opacity : 0.2
                            image.source: "qrc:/images/icon-add-3x.png"

                            onClicked: {
                                voltageSlider.value = Math.min(voltageSlider.to, voltageSlider.value + voltageSlider.stepSize)

                            }
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: resp.avg(80)

                Label {
                    id: inputLabel
                    text: "Input"
                    font.pixelSize: resp.avg(60)
                    color: "#606060"
                }

                Item { Layout.fillWidth: true }
                
                CoreTextField {
                    id: voltageInput
                    implicitHeight: resp.avg(150)
                    placeholder: ""
                    Layout.fillWidth: true
                    font.pixelSize: resp.avg(58)

                    fillColor : "#ffffff"
                    borderColor: "#E0E0E0"
                    borderWidth : resp.avg(8)
                    borderRadius: resp.avg(25)
                    textColor: "#AFAFAF"
                    placeholderTextColor: "#AFAFAF"
                    text: voltageSlider.value.toFixed(1)

                    validator: DoubleValidator {
                            bottom: 0
                            top: 3.3
                            notation: DoubleValidator.StandardNotation
                    }
                }
            }

            CoreButton {
                id: submitBtn
                Layout.fillWidth: true
                implicitHeight: resp.avg(140)
                color : "#0F6CBD"
                radius: resp.avg(25)
                elevate: true

                label.text: "Submit"
                label.color: "#FFFFFF"
                label.font.pixelSize: resp.avg(56)
                label.font.weight: Font.Bold

                onClicked: {
                    voltage_controller.set_voltage(parseFloat(voltageInput.text))
                }
            }
        }

        Popup {
            id: infoPopup
            width: parent.width - 60
            height: parent.height - 40
            modal: true
            anchors.centerIn: parent
            background: Rectangle {
                color: "white"
                radius: resp.avg(25)
            }

            ColumnLayout {
                anchors.centerIn: parent
                spacing: resp.avg(20)
                width: parent.width - resp.avg(40)

                Label {
                    text: "Voltage Control Unit"
                    font.pixelSize: resp.avg(60)
                    font.bold: true
                    color: "#0F6CBD"
                    Layout.alignment: Qt.AlignHCenter
                }

                Label {
                    text: "Version: 1.0.0"
                    font.pixelSize: resp.avg(40)
                    color: "#606060"
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: resp.avg(10)
                }

                Label {
                    text: "Control voltage output from 0V to\n3.3V using PWM"
                    font.pixelSize: resp.avg(48)
                    color: "#000000"
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: resp.avg(30)
                    wrapMode: Text.WordWrap
                }
            }

            CoreButton {
                id: backBtn
                height: resp.avg(170)
                width : resp.avg(480)
                anchors.bottom : parent.bottom
                anchors.horizontalCenter : parent.horizontalCenter
                anchors.bottomMargin: resp.avg(30)

                color : "#0F6CBD"
                radius: resp.avg(25)
                elevate: true

                label.text: "Back"
                label.color: "#FFFFFF"
                label.font.pixelSize: resp.avg(40)
                label.font.weight: Font.Bold

                onClicked: infoPopup.close()
            }
        }
    }
}
