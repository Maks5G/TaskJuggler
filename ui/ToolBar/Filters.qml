import QtQuick 2.15
import StyleModule 1.0
import States 1.0

Row{
    id: filterRow
    width: (root.width - tools.width - languages.width - dayAndNight.width) *7/12
    spacing: Style.tinySpacing

    ListModel{
        id: model
        ListElement{listText: qsTr("All")}
        ListElement{listText: qsTr("In proccess")}
        ListElement{listText: qsTr("Done")}
        ListElement{listText: qsTr("Hold")}
        ListElement{listText: qsTr("Miss")}
    }

    Repeater {
        model: model
        Rectangle{
            height: root.height
            width: parent.width / 5 - filterRow.spacing
            radius: 10
            scale: 0.9
            color: mouseArea.containsPress ? Style.darkColor : mouseArea.containsMouse ? Style.primaryColor : Style.lightColor
            border.color: Style.borderColor

            Text{
                width: parent.width
                anchors.centerIn: parent
                text: listText  + mytrans.emptyString
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Style.defaultTextSize
                elide: Text.ElideMiddle // якщо текст не поміщається, то він частково чи повністю замінється 3 крапками
                color: Style.textColor
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    switch(index){
                    case 0:
                        myModel.where = 0
                        break;
                    case 1:
                        myModel.where = States.InProccess;
                        break;
                    case 2:
                        myModel.where = States.Done;
                        break;
                    case 3:
                        myModel.where = States.Hold;
                        break;
                    case 4:
                        myModel.where = States.Miss;
                        break;
                    default:
                        break;
                    }
                    myModel.updateModel();
                }
            }
        }
    }
}
