import QtQuick

Item {
    id: root

    property bool darkMode: false

    // Color Palettes
    property alias colorPrimary: primary
    property alias colorSecondary: secondary
    property alias colorBackground: background
    property alias colorSurface: surface
    property alias colorError: error
    property alias colorSuccess: success

    // Fonts
    property string primaryFont: "Poppins"
    property string secondaryFont: "Robotto"

    /**
        Color palette structure is based on Google's Material theme guidelines.
        For more details check out:

        https://m2.material.io/design/color/the-color-system.html#color-theme-creation

        - Default shades are light and dark but additional color shades can be defined as per need.
        - The color 'contrast' defines the 'On' colors as per material theme guidelines.
        - In case of light/dark mode, left color specifies the light and right for dark mode theme
    **/

    QtObject {
        id: primary
        readonly property color light: !root.darkMode ?         "#292E8E" : ""
        readonly property color dark: !root.darkMode ?          "#0A1258" : ""
        readonly property color contrast: !root.darkMode ?      "#FFFFFF" : ""
        readonly property color contrastL1: !root.darkMode ?    "#5A5FBC" : ""
    }

    QtObject {
        id: secondary
        readonly property color light: !root.darkMode ?         "#DA251C" : ""
        readonly property color dark: !root.darkMode ?          "#BF3129" : ""
        readonly property color contrast: !root.darkMode ?      "#FFFFFF" : ""
    }

    QtObject {
        id: background
        readonly property color light: !root.darkMode ?         "#F1F1F1" : ""
        readonly property color dark: !root.darkMode ?          "#F1F1F1" : ""
        readonly property color contrast: !root.darkMode ?      "#303030" : ""
        readonly property color contrastL1: !root.darkMode ?    "#555555" : ""
    }

    QtObject {
        id: surface
        readonly property color light: !root.darkMode ?         "#FFFFFF" : ""
        readonly property color dark: !root.darkMode ?          "#F0F0F0" : ""
        readonly property color contrast: !root.darkMode ?      "#303030" : ""
        readonly property color contrastL1: !root.darkMode ?    "#555555" : ""
        readonly property color contrastL2: !root.darkMode ?    "#747474" : ""
        readonly property color contrastL3: !root.darkMode ?    "#999898" : ""
        readonly property color contrastL4: !root.darkMode ?    "#A2A2A2" : ""
        readonly property color contrastL5: !root.darkMode ?    "#D4D4D4" : ""
        readonly property color highlight: !root.darkMode ?     "#F1F2FF" : ""
        readonly property color tint: !root.darkMode ?          "#F5F7FA" : ""
    }

    QtObject {
        id: error
        readonly property color light: !root.darkMode ?         "#FFEFEE" : ""
        readonly property color dark: !root.darkMode ?          "#FFC6C3" : ""
        readonly property color contrast: !root.darkMode ?      "#BF3029" : ""
    }

    QtObject {
        id: success
        readonly property color light: !root.darkMode ?         "#EBFFEE" : ""
        readonly property color dark: !root.darkMode ?          "#EBFFEE" : ""
        readonly property color contrast: !root.darkMode ?      "#0DA01E" : ""
    }
}
