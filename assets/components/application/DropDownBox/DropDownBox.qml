import QtQuick
import QtQuick.Controls.Universal

ComboBox {
    id: root
    implicitWidth: 150
    implicitHeight: 40

    property string keyID: "item"
    property bool enableSearch: false

    model: ListModel {
        ListElement {item: "Item 1"}
        ListElement {item: "Item 2"}
        ListElement {item: "Item 3"}
        ListElement {item: "Item 4"}
    }

    contentItem: Text {
        id: selectedItemText
        height: parent.height
        leftPadding: resp.avg(30)
        verticalAlignment: Text.AlignVCenter
        color: theme.colorSurface.contrastL1
        text: root.displayText

        font.pixelSize: resp.avg(18)
        font.family: theme.primaryFont
        font.weight: Font.Normal

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: resp.avg(50)
    }

    indicator: Image {
        id: dropDownIcon
        width: resp.avg(14)
        x: root.width - width - root.rightPadding
        y: root.topPadding + (root.availableHeight - height) / 2
        source: "qrc:/images/icon-dropdown.png"
        sourceSize: Qt.size(dropDownIcon.width, dropDownIcon.width)
        fillMode: Image.PreserveAspectFit
    }

    background: Rectangle {
        color: theme.colorSurface.light
        radius: resp.avg(8)
        border.color: theme.colorSurface.contrastL5
        border.width: 1
    }

    popup: Popup {
        id: dropDown
        width: root.width
        height: dropDownFlickable.contentHeight > resp.avg(250) ? resp.avg(250) : dropDownFlickable.contentHeight
                                                                  + searchField.height
                                                                  + noDataInfo.height
                                                                  + (root.enableSearch ? resp.avg(20) : 0)
        y: root.height + resp.avg(5)
        padding: 1

        contentItem: Item {
            anchors.fill: parent

            TextField {
                id: searchField
                height: visible ? resp.avg(40) : 0
                leftPadding: resp.avg(30)
                color: theme.colorSurface.contrastL1
                visible: root.enableSearch

                placeholderText: "Search"
                placeholderTextColor: theme.colorSurface.contrastL4

                font.pixelSize: resp.avg(18)
                font.family: theme.primaryFont
                font.weight: Font.Normal

                background: Rectangle {
                    color: theme.colorSurface.light
                    radius: resp.avg(8)
                    border.color: theme.colorSurface.contrastL5
                    border.width: 1
                }

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: root.enableSearch ? resp.avg(10) : 0
            }

            Flickable {
                id: dropDownFlickable
                contentHeight: dropDownListView.height
                flickableDirection: Flickable.VerticalFlick
                clip: true

                anchors.top: searchField.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: root.enableSearch ? resp.avg(10) : 0

                ScrollIndicator.vertical: ScrollIndicator { }

                ListView {
                    id: dropDownListView
                    width: parent.width
                    height: contentItem.childrenRect.height
                    currentIndex: root.highlightedIndex
                    interactive: false
                    model: root.delegateModel
                }
            }

            Text {
                id: noDataInfo
                height: visible ? resp.avg(50) : 0
                text: "No Match Found"
                color: theme.colorSurface.contrastL1
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(16)
                font.weight: Font.Normal
                verticalAlignment: Text.AlignVCenter
                visible: dropDownFlickable.contentHeight < resp.avg(21)

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: resp.avg(10)
            }
        }

        background: Rectangle {
            id: dropDownBackground
            anchors.fill: parent
            color: theme.colorSurface.light
            border.color: theme.colorSurface.contrastL5
            radius: resp.avg(10)
            clip: true
        }

        //-------- Custon Animation ---------//
        opacity: 0
        onOpened: dropDown.opacity = 1
        onClosed: dropDown.opacity = 0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
        //------ Custon Animation End -------//
    }

    delegate: ItemDelegate {
        id: dropBoxDelegate
        width: root.width
        height: visible ? root.height : 0
        highlighted: root.highlightedIndex === index
        visible: model[root.keyID].toLowerCase().includes(searchField.text.toLowerCase()) ? true : false

        background: Rectangle {
            color: dropBoxDelegate.highlighted ? theme.colorSurface.highlight : "transparent"
            radius: resp.avg(10)
            opacity: 0.7
        }

        contentItem: Item {
            anchors.fill: parent
            Text {
                id: itemText
                text: model[root.keyID]
                color: theme.colorSurface.contrastL1
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(16)
                font.weight: Font.Normal
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: resp.width(28)
            }
        }

        onClicked: root.displayText = model[root.keyID]
    }

    //////////////////////////////
    //// Javascript Functions ////
    //////////////////////////////

    function clear() {
        root.displayText = ""
    }

    function setText(text) {
        root.displayText = text
        dropDown.close()
    }

    function setItemAtIndex(index) {
        root.displayText = root.model.get(index)[root.keyID]
        root.currentIndex = index
    }

    Component.onCompleted: root.setItemAtIndex(0) // Necessary for custon C++ models
}
