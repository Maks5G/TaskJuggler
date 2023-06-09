import QtQuick 2.15
import StyleModule 1.0
import Timer 1.0

Rectangle{
    property alias listView: listView

    id: tasksView
    color: Style.backgroundColor

    ListView {
        id: listView
        anchors{
            top: orderBy.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        anchors.margins: Style.mediumOffset
        model: myModel
        spacing: Style.mediumSpacing
        delegate: ListDelegate{}
    }

    MyTimer {
        id: myTimer
        Component.onCompleted: { // конструктор, в якому стартуємо таймер із вбудованою перевіркою
            myTimer.start(myModel, database);
        }
    }

    OrderBy {
        id: orderBy
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }
}
