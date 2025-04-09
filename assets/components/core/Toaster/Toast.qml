import QtQuick

Rectangle {
    id: root
    width: childrenRect.width + 2 * margin
    height: childrenRect.height + 2 * margin
    radius: margin
    opacity: 0
    color: "white"

    property real margin: 10
    property real maxTextWidth: textObj.textWidth
    property real time: defaultTime
    property bool selfDestroying: false

    readonly property real defaultTime: 3000
    readonly property real fadeTime: 300

    anchors.horizontalCenter: parent.horizontalCenter

    function show(text, duration) {
        textObj.text = text;

        if(typeof duration !== "undefined") {
            if(duration >= 2 * fadeTime) {
                time = duration;
            }
            else {
                time = 2 * fadeTime;
            }
        }
        else {
            time = defaultTime;
        }

        anim.start();
    }

    Text {
        id: textObj
        width: Math.min(textWidth, root.maxTextWidth)
        text: ""
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WordWrap
        x: margin
        y: margin

        readonly property alias textWidth: textMetrics.boundingRect.width
        readonly property alias textHeight: textMetrics.boundingRect.height

        TextMetrics {
          id: textMetrics
          font: textObj.font
          text: textObj.text
          elide: textObj.elide
        }
    }

    SequentialAnimation on opacity {
        id: anim
        running: false

        NumberAnimation {
            to: 0.9
            duration: fadeTime
        }

        PauseAnimation {
            duration: time - 2*fadeTime
        }

        NumberAnimation {
            to: 0
            duration: fadeTime
        }

        onRunningChanged: {
            if(!running && selfDestroying)
                root.destroy();
        }
    }

    Component.onDestruction: root.parent.activeToasts -= 1
}
