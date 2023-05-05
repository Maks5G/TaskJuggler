import QtQuick 2.15
import StyleModule 1.0
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import States 1.0
import "../TaskDescription"

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
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    switch(index){
                    case 0:
                        dialog.open();
                        break;
                    case 1:
                        dialogDelete.open()
                        break;
                    case 2:
                        areYouSure._state = States.Done
                        areYouSure.open()
                        break;
                    case 3:
                        areYouSure._state = States.Hold
                        areYouSure.open()
                        break;
                    default:
                        break;
                    }
                }
            }
        }
    }
}
