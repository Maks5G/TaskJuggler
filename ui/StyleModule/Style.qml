pragma Singleton
import QtQuick 2.15

QtObject {
    property bool isDarkTheme: true
    property color primaryColor: isDarkTheme ? "#424242" : "#E84141"
    property color darkColor: isDarkTheme ? "#212121" : "#C53333"
    property color lightColor: isDarkTheme ? "#616161" : "#FF6868"
    property color backgroundColor: isDarkTheme ? "#424242" : "#EEEEEE"
    property color textColor: isDarkTheme ? "#EEEEEE" : "black"
    property color text2Color: isDarkTheme ? "#b5b5b5" : "#313131"
    property color borderColor: isDarkTheme ? "white" : "black"

    readonly property int defaultTextSize: 20

    readonly property int bigOffset: 15
    readonly property int mediumOffset: 10
    readonly property int tinyOffset: 4

    readonly property int bigSpacing: 20
    readonly property int mediumSpacing: 10
    readonly property int tinySpacing: 4
}
