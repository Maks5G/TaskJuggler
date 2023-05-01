import QtQuick 2.15

Row{
    id: toolsRow
    spacing: 10

    Image {
        id: plus
        source: "qrc:/ui/assets/plus.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
    }

    Image {
        id: bin
        source: "qrc:/ui/assets/bin.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
    }

    Image {
        id: done
        source: "qrc:/ui/assets/done.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
    }

    Image {
        id: holdOn
        source: "qrc:/ui/assets/stop-sign.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
    }
}
