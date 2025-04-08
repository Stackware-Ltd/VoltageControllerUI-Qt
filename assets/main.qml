import QtQuick
import QtQuick.Controls

import screens
Window {
    id: rootWindow
    width: 480
    height: 320
    visible: true
    title: qsTr("Voltage Control Unit Program")
    color: "#FFFFFF"

    ScreenMain {
        id: mainScreen
        width: parent.width
        height: parent.height
    }
}
