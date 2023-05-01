import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle{
    id: root
    anchors{
        left: parent.left
        right: parent.right
    }
    height: 52
    color: "#E84141"

    Tools{
        id: tools
        anchors{
            left: root.left
            top: root.top
            bottom: root.bottom
            margins: 4
        }
    }

    Filters{
        id: filterRow
        anchors{
            left: tools.right
            top: root.top
            bottom: root.bottom
            leftMargin: 10
        }
    }

    Image {
        id: dayAndNight
        source: "qrc:/ui/assets/day-and-night.png"
        height: parent.height - 4
        fillMode: Image.PreserveAspectFit
        anchors{
            verticalCenter: root.verticalCenter
            right: root.right
            rightMargin: 4
        }
    }

    Rectangle{
        id: separator
        height: root.height
        width: 2
        anchors{
            right: dayAndNight.left
            rightMargin: 4
        }
    }

    Languages{
        id: languages
        anchors{
            right: separator.left
            top: root.top
            bottom: root.bottom
            margins: 4
        }
    }

    Searcher {
        id: searcher
        anchors{
            top: root.top
            bottom: root.bottom
            right: languages.left
            left: filterRow.right
            margins: 4
        }
    }

}
