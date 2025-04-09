import QtQuick
import QtQuick.Window

QtObject {
    id: root

    readonly property int baseWidth: 1920
    readonly property int baseHeight: 1080

    function width(w) {
        return rootWindow.width * (w/baseWidth);
    }

    function height(h) {
        return rootWindow.height * (h/baseHeight);
    }

    function avg(a) {
        return Math.round((width(a) + height(a)) / 2);
    }

    function orientation() {
        return Screen.primaryOrientation
    }
}
