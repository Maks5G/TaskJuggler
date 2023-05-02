import QtQuick 2.15
import StyleModule 1.0

Row{
    id: toolsRow
    spacing: Style.mediumSpacing

    ListModel {
        id: model
        ListElement {listId: "plus"; imgSource: "qrc:/ui/assets/plus.png";}
        ListElement {listId: "bin"; imgSource: "qrc:/ui/assets/bin.png";}
        ListElement {listId: "done"; imgSource: "qrc:/ui/assets/done.png";}
        ListElement {listId: "holdOn"; imgSource: "qrc:/ui/assets/stop-sign.png";}
    }

    Repeater {
        model: model
        Image {
            id: listId
            source: imgSource
            fillMode: Image.PreserveAspectFit
            height: parent.height
        }
    }
}
