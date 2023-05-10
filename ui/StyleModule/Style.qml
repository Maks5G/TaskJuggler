pragma Singleton
import QtQuick 2.15
import States 1.0

//Всі стилі в одному файлі, використовуючи сінглтон
QtObject {
    property bool isDarkTheme: true
    readonly property color primaryColor: isDarkTheme ? "#424242" : "#E84141"
    readonly property color darkColor: isDarkTheme ? "#212121" : "#C53333"
    readonly property color lightColor: isDarkTheme ? "#616161" : "#FF6868"
    readonly property color backgroundColor: isDarkTheme ? "#616161" : "#C1C1C1"
    readonly property color textColor: isDarkTheme ? "#EEEEEE" : "black"
    readonly property color text2Color: isDarkTheme ? "#b5b5b5" : "#313131"
    readonly property color borderColor: isDarkTheme ? "white" : "black"
    readonly property color delegateColor: isDarkTheme ? "#424242" : "#EEEEEE"

    readonly property int tinyTextSize: 17
    readonly property int defaultTextSize: 20
    readonly property int bigTextSize: 25

    readonly property int bigOffset: 15
    readonly property int mediumOffset: 10
    readonly property int tinyOffset: 4

    readonly property int bigSpacing: 20
    readonly property int mediumSpacing: 10
    readonly property int tinySpacing: 4
}
