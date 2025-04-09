import QtQuick
import QtQuick.Controls.Universal

ComboBox {
    id: root
    implicitWidth: 150
    implicitHeight: 40

    model: ListModel {
        ListElement {text: "Item 1"}
        ListElement {text: "Item 2"}
        ListElement {text: "Item 3"}
        ListElement {text: "Item 4"}
    }

    property alias dropBoxBackground: dropBoxBackground
    property alias dropBoxDisplayText: selectedItemText
    property alias dropDownBackground: dropDownBackground

    property string indicatorColor: "#991B1B1B"
    property string delegateTextFieldColor: "#991B1B1B"

    contentItem: Item {
        anchors.fill: parent

        Text {
            id: selectedItemText
            text: root.displayText
            color: root.delegateTextFieldColor
            font.family: theme.primaryFont
            font.pixelSize: resp.avg(14)
            font.weight: Font.Normal
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: resp.width(28)
        }
    }

    indicator: Canvas {
        id: dropBoxIndicator
        x: root.width - width - root.rightPadding
        y: root.topPadding + (root.availableHeight - height) / 2
        width: resp.avg(11)
        height: resp.avg(6)
        contextType: "2d"

        Connections {
            target: root
            function onPressedChanged() { dropBoxIndicator.requestPaint(); }
        }

        onPaint: {
            var ctx = dropBoxIndicator.getContext('2d');

            ctx.reset();
            ctx.moveTo(0, 0);
            ctx.lineTo(width, 0);
            ctx.lineTo(width / 2, height);
            ctx.closePath();
            ctx.fillStyle = root.indicatorColor;
            ctx.fill();
        }
    }

    background: Rectangle {
        id: dropBoxBackground
        anchors.fill: parent
        color: "#FFFFFF"
        radius: resp.avg(12)
        border.width: root.visualFocus ? 2 : 1
        border.color: "#99A6A6A6"
        clip: true
    }

    popup: Popup {
        id: dropDown
        width: root.width
        height: contentItem.implicitHeight
        y: root.height + resp.avg(5)
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: root.delegateModel
            currentIndex: root.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            id: dropDownBackground
            anchors.fill: parent
            color: "#FFFFFF"
            border.color: "#99A6A6A6"
            radius: resp.avg(12)
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
        height: root.height
        highlighted: root.highlightedIndex === index

        contentItem: Item {
            anchors.fill: parent

            Text {
                id: itemText
                text: model.text
                color: root.delegateTextFieldColor
                font.family: theme.primaryFont
                font.pixelSize: resp.avg(14)
                font.weight: Font.Normal
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: resp.width(28)
            }
        }
    }
}
