import QtQuick

Column{
    id: root
    z: Infinity
    spacing: 5

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom
    anchors.bottomMargin: parent.height * 0.1

    property int activeToasts: 0
    property var toastComponent: Qt.createComponent("Toast.qml")

    function show(text, duration){
        var toast = toastComponent.createObject(root);
        toast.selfDestroying = true;
        toast.maxTextWidth = parent.width * 0.9;
        toast.show(text, duration);
        root.activeToasts += 1
    }
}
