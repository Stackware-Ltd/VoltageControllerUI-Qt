import QtQuick
import QtQuick.Controls.Universal

ComboBox {
    id: root
    implicitWidth: 150
    implicitHeight: 40

    property string keyID: "item"
    property string placeholderText: "Placeholder"
    property string text: selectedItemText.text

    model: ListModel {
        ListElement {item: "Item 1"}
        ListElement {item: "Item 2"}
        ListElement {item: "Item 3"}
        ListElement {item: "Item 4"}
    }

    contentItem: TextField {
        id: selectedItemText
        leftPadding: resp.avg(30)
        color: theme.colorSurface.contrastL1

        placeholderText: root.placeholderText
        placeholderTextColor: theme.colorSurface.contrastL4

        font.pixelSize: resp.avg(18)
        font.family: theme.primaryFont
        font.weight: Font.Normal

        background: Item {}

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: resp.avg(50)

        onTextChanged: dropDown.open()
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
        height: dropDownFlickable.contentHeight > resp.avg(250) ? resp.avg(250) : dropDownFlickable.contentHeight + noDataInfo.height + resp.avg(20)
        y: root.height + resp.avg(5)
        padding: 1

        contentItem: Flickable {
            id: dropDownFlickable
            anchors.fill: parent
            contentHeight: dropDownListView.height
            flickableDirection: Flickable.VerticalFlick
            clip: true

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

        background: Rectangle {
            id: dropDownBackground
            anchors.fill: parent
            color: theme.colorSurface.light
            border.color: theme.colorSurface.contrastL5
            radius: resp.avg(10)
            clip: true

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
        visible: model[root.keyID].toLowerCase().includes(selectedItemText.text.toLowerCase()) ? true : false

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

        onClicked: selectedItemText.text = model[root.keyID]
    }

    //////////////////////////////
    //// Javascript Functions ////
    //////////////////////////////

    function clear() {
        selectedItemText.text = ""
        dropDown.close()
    }

    function setText(text) {
        selectedItemText.text = text
        dropDown.close()
    }

    function setItemAtIndex(index) {
        selectedItemText.text = root.model.get(index)[root.keyID]
        root.currentIndex = index
        dropDown.close()
    }
}
