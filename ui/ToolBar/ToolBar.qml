import QtQuick 2.15
import StyleModule 1.0

Rectangle{
    id: root
    anchors{
        left: parent.left
        right: parent.right
    }
    height: 52
    color: Style.primaryColor

    Tools{
        id: tools
        anchors{
            left: root.left
            top: root.top
            bottom: root.bottom
            margins: Style.tinyOffset
        }
    }

    Filters{
        id: filterRow
        anchors{
            left: tools.right
            top: root.top
            bottom: root.bottom
            leftMargin: Style.mediumOffset
        }
    }

    Image {
        id: dayAndNight
        source: "qrc:/ui/assets/day-and-night.png"
        height: parent.height - Style.tinyOffset
        fillMode: Image.PreserveAspectFit
        anchors{
            verticalCenter: root.verticalCenter
            right: root.right
            rightMargin: Style.tinyOffset
        }
    }

    Rectangle{
        id: separator
        height: root.height
        width: 1
        anchors{
            right: dayAndNight.left
            rightMargin: Style.tinyOffset
        }
        color: Style.borderColor
    }

    Languages{
        id: languages
        anchors{
            right: separator.left
            top: root.top
            bottom: root.bottom
            margins: Style.tinyOffset
        }
    }

    Searcher {
        id: searcher
        anchors{
            top: root.top
            bottom: root.bottom
            right: languages.left
            left: filterRow.right
            margins: Style.tinyOffset
        }
    }
}
