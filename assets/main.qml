import QtQuick
import QtQuick.Controls

import components.core
import components.application
import screens

Window {
    id: rootWindow
    width: 480
    height: 320
    visible: true
    title: qsTr("Voltage Control Unit Program")
    color: theme.colorBackground.light


    ThemeProvider {id: theme}
    ResponsiveHandler {id: resp}

    ScreenMain {
        id: mainScreen
        width: parent.width
        height: parent.height
    }
}
