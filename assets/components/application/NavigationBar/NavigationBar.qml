import QtQuick
import QtQuick.Window
import QtQuick.Controls.Universal
import QtQuick.Effects

Item {
    id: root
    implicitWidth: 300
    implicitHeight: parent.height

    property var activePage: screenHome
    property int currentNavbarIndex: 0

    property string logoSrc: ""

    Rectangle {
        id: navbarBackground
        width: parent.width/3
        height: parent.height
        color: theme.colorPrimary.light
    }

    Rectangle {
        id: navbarContainer
        anchors.fill: parent
        color: theme.colorPrimary.light
        radius: resp.avg(30)
        clip: true

        Column {
            id: navbarBtnCol
            spacing: 0

            anchors.top: navbarContainer.top
            anchors.topMargin: resp.avg(200)
            anchors.horizontalCenter: navbarContainer.horizontalCenter

            // Home Screen
            NavigationButton {
                id: homeNavBtn
                width: resp.avg(300)
                height: resp.avg(82)
                iconSize: resp.avg(32)

                iconOn: "qrc:/images/icon-reminder-white.png"
                iconOff: "qrc:/images/icon-reminder-white.png"
                highlightColor: theme.colorPrimary.dark
                highlightRadius: resp.avg(16)

                label: qsTr("Test Setups")
                labelSize: resp.avg(18)
                labelColorOn: theme.colorPrimary.contrast
                labelColorOff: theme.colorPrimary.contrast

                isOn: root.activePage == screenHome ? true : false

                mouseArea.onPressed: {
                    root.currentNavbarIndex = 0
                    root.activePage = screenHome
                }
            }

            // Add Patient Screen
            NavigationButton {
                id: settingsNavBtn
                width: resp.avg(300)
                height: resp.avg(82)
                iconSize: resp.avg(32)

                iconOn: "qrc:/images/icon-setting-filled.png"
                iconOff: "qrc:/images/icon-setting-filled.png"
                highlightColor: theme.colorPrimary.dark
                highlightRadius: resp.avg(16)

                label: qsTr("Settings")
                labelSize: resp.avg(18)
                labelColorOn: theme.colorPrimary.contrast
                labelColorOff: theme.colorPrimary.contrast

                isOn: root.activePage == screenSettings ? true : false

                mouseArea.onPressed: {
                    root.currentNavbarIndex = 1
                    root.activePage = screenSettings
                }
            }
        }

        Rectangle {
            id: logoContainer
            height: resp.avg(86)
            color: theme.colorPrimary.contrast
            radius: resp.avg(72)

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: resp.avg(37)
            anchors.leftMargin: resp.avg(86)
            anchors.rightMargin: resp.avg(86)

            Image {
                id: companyLogo
                width: resp.avg(68)
                fillMode: Image.PreserveAspectFit
                source: root.logoSrc

                anchors.verticalCenter: logoContainer.verticalCenter
                anchors.left: logoContainer.left
                anchors.leftMargin: resp.avg(26)
            }

            Label {
                id: companyLogoLabel
                text: "LOGO"
                color: theme.colorSecondary.light
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(28)
                font.weight: Font.Bold

                anchors.centerIn: parent
                // anchors.verticalCenter: companyLogo.verticalCenter
                // anchors.left: companyLogo.right
                // anchors.leftMargin: resp.avg(10)
            }
        }
    }

    MultiEffect {
        id: shadowEffect
        anchors.fill: navbarContainer
        source: navbarContainer
        shadowEnabled: true
        autoPaddingEnabled: true
        blurMultiplier: 1
        shadowBlur: 1.0
        shadowScale: 1.0
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 11
        shadowColor: "#1B0C51"
        opacity: 0.25
    }
}
