import QtQuick 2.15
//import QtQuick.Layouts 1.15
//import QtQuick.Controls 2.15
import StyleModule 1.0


Rectangle{
    property alias listView: listView

    id: tasksView
    color: Style.backgroundColor

    ListView {
        id: listView
        anchors.fill: parent
        anchors.margins: Style.mediumOffset
        model: myModel
        spacing: Style.mediumSpacing
        delegate: ListDelegate{}
        onCurrentIndexChanged: {
//            console.log(currentIndex);
        }
    }

}
