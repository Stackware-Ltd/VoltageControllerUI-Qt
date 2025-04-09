import QtQuick
import QtQuick.Controls.Universal

Rectangle {
    id:root
    implicitWidth: 40
    implicitHeight: 40
    color: theme.colorSecondary.dark
    radius: root.width/2
    visible: root.notificationCounter > 0 ? true : false

    property int notificationCounter: 0

    Label {
        id: notificationCount
        text: root.notificationCounter
        font.family: theme.primaryFont
        font.pixelSize: root.width * 0.6
        font.weight: Font.Normal
        color: theme.colorSecondary.contrast

        anchors.centerIn: parent
    }
}
