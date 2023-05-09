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
        delegate: ListDelegate{/* id: delegate*/}
        onCurrentIndexChanged: {
//            console.log(currentIndex);

        }
    }

    MyTimer {
        id: myTimer
        Component.onCompleted: {
            myTimer.start(myModel, database);
            myTimer.compareDate();
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
