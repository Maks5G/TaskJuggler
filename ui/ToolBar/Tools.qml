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
        ListElement {imgSource: "qrc:/ui/assets/plus.png";}
        ListElement {imgSource: "qrc:/ui/assets/bin.png";}
        ListElement {imgSource: "qrc:/ui/assets/done.png";}
        ListElement {imgSource: "qrc:/ui/assets/stop-sign.png";}
        ListElement {imgSource: "qrc:/ui/assets/makeInProccess.png";}
    }

    Repeater {
        model: model
        Image {
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
                    case 4:
                        areYouSure._state = States.InProccess
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
