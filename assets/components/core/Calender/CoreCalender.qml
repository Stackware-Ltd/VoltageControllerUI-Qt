import QtQuick
import QtQuick.Controls.Universal
import QtQuick.Layouts

import components.core

CoreCardHolder {
    id: root
    implicitWidth: 350
    implicitHeight: 350
    radius: resp.avg(20)
    dropshadow.opacity: 0.4

    color: theme.colorSurface.light

    property date selectedDate: new Date()  // Default highlight on current date
    property int selectedYear: selectedDate.getFullYear()
    property bool enableYearSelect: false

    readonly property var months: [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ]

    onSelectedDateChanged: {
        calenderView.positionViewAtIndex(calenderView.model.indexOf(root.selectedDate), ListView.Beginning)
    }
    /////////////////////////
    //// Calender Navbar ////
    /////////////////////////

    Item {
        id: calenderNavBar
        height: resp.avg(50)
        clip: true

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        Row {
            anchors.centerIn: parent
            spacing: resp.avg(20)

            CoreImageButton {
                id: prevMonthBtn
                width: resp.avg(14)
                srcPressed: "qrc:/images/icon-dropdown.png"
                srcUnpressed: "qrc:/images/icon-dropdown.png"
                rotation: 90
                visible: !root.enableYearSelect

                anchors.verticalCenter: parent.verticalCenter

                onPressed: calenderView.currentIndex === 0 ? calenderView.currentIndex : calenderView.currentIndex--
            }

            Text {
                id: monthSelectBtn
                text: root.months[calenderView.model.monthAt(calenderView.currentIndex)]
                color: theme.colorSurface.contrast
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(20)
                visible: !root.enableYearSelect

                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: { }

                    // HoverHandler {
                    //     acceptedDevices: PointerDevice.AllDevices
                    //     cursorShape: Qt.PointingHandCursor
                    // }
                }
            }

            Text {
                id: yearSelectBtn
                text: root.enableYearSelect ? "Back to Calender" : calenderView.model.yearAt(calenderView.currentIndex)
                color: theme.colorSurface.contrast
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(20)

                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.enableYearSelect = !root.enableYearSelect

                    HoverHandler {
                        acceptedDevices: PointerDevice.AllDevices
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            CoreImageButton {
                id: nextMonthBtn
                width: resp.avg(14)
                srcPressed: "qrc:/images/icon-dropdown.png"
                srcUnpressed: "qrc:/images/icon-dropdown.png"
                rotation: -90
                visible: !root.enableYearSelect

                anchors.verticalCenter: parent.verticalCenter

                onPressed: calenderView.currentIndex === (calenderView.count - 1) ? calenderView.currentIndex : calenderView.currentIndex++
            }
        }
    }

    ////////////////////////////
    //// Main Calender View ////
    ////////////////////////////

    ListView {
        id: calenderView
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        highlightRangeMode: ListView.StrictlyEnforceRange
        clip: true
        visible: !root.enableYearSelect

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: calenderNavBar.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: resp.avg(5)
        anchors.rightMargin: resp.avg(5)
        anchors.bottomMargin: resp.avg(5)

        model: CalendarModel {
            from: new Date(2015, 0, 1)
            to: new Date(2075, 11, 31)
        }

        delegate: Item {
            id: calenderViewDelegate
            width: calenderView.width
            height: calenderView.height

            DayOfWeekRow {
                id: daysHeader
                height: resp.avg(50)
                locale: monthDaysGrid.locale

                anchors.left: calenderViewDelegate.left
                anchors.right: calenderViewDelegate.right
                anchors.top: calenderViewDelegate.top
            }

            MonthGrid {
                id: monthDaysGrid
                month: model.month
                year: model.year
                locale: Qt.locale("en_US")

                anchors.left: calenderViewDelegate.left
                anchors.right: calenderViewDelegate.right
                anchors.top: daysHeader.bottom
                anchors.bottom: calenderViewDelegate.bottom

                delegate: ItemDelegate {
                    id: monthGridDelegate
                    highlighted: root.selectedDate.getFullYear() === model.year &&
                                 root.selectedDate.getMonth() === model.month &&
                                 root.selectedDate.getDate() === model.day

                    background: Rectangle {
                        height: monthGridDelegate.height
                        width: monthGridDelegate.height
                        color: monthGridDelegate.highlighted ? theme.colorSecondary.light : "transparent"
                        radius: height/2
                        opacity: 0.7

                        anchors.centerIn: parent

                        Text {
                            text: model.day
                            color: monthGridDelegate.highlighted ? theme.colorSecondary.contrast : theme.colorSurface.contrast
                            font.family: theme.primaryFont
                            font.pixelSize: resp.avg(14)
                            opacity: model.month === monthDaysGrid.month ? 1 : 0.3

                            anchors.centerIn: parent
                        }
                    }

                    onClicked: function() {
                        root.selectedDate = new Date(model.year, model.month, model.day)
                    }
                }
            }
        }

        ScrollIndicator.horizontal: ScrollIndicator { }

        Component.onCompleted: {
            calenderView.positionViewAtIndex(model.indexOf(root.selectedDate), ListView.Beginning)
        }
    }

    /////////////////////////////
    //// Year Selection View ////
    /////////////////////////////

    GridView {
        id: yearSelectionGrid
        cellWidth: yearSelectionGrid.width / 3
        cellHeight: yearSelectionGrid.height / 4
        clip: true
        visible: root.enableYearSelect

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: calenderNavBar.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: resp.avg(5)
        anchors.rightMargin: resp.avg(5)
        anchors.bottomMargin: resp.avg(5)

        model: ListModel {
            id: yearModel
            Component.onCompleted: {
                for (let y = calenderView.model.from.getFullYear(); y <= calenderView.model.to.getFullYear(); y++) {
                    yearModel.append({ year: y })
                }
                // Position the view to the grid containing the current year
                yearSelectionGrid.positionViewAtIndex(selectedYear - calenderView.model.from.getFullYear(), GridView.Beginning)
            }
        }

        delegate: ItemDelegate {
            id: yearGridDelegate
            width: yearSelectionGrid.cellWidth
            height: yearSelectionGrid.cellHeight
            highlighted: model.year === selectedYear


            background: Rectangle {
                height: yearGridDelegate.height * 0.7
                width: yearGridDelegate.width* 0.8
                color: yearGridDelegate.highlighted ? theme.colorSurface.highlight : theme.colorBackground.light
                radius: height / 2

                anchors.centerIn: parent

                Text {
                    anchors.centerIn: parent
                    text: model.year
                    color: theme.colorSurface.contrast
                    font.family: theme.primaryFont
                    font.pixelSize: resp.avg(16)
                    font.weight: Font.DemiBold
                }
            }

            onClicked: {
                selectedYear = model.year
                calenderView.positionViewAtIndex(calenderView.model.indexOf(new Date(selectedYear, calenderView.model.monthAt(calenderView.currentIndex), 1)), ListView.Beginning)
                root.enableYearSelect = false
            }
        }
    }

}
