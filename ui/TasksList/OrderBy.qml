import QtQuick 2.15
import StyleModule 1.0

Rectangle {
    id: orderBy
    color: Style.primaryColor
    height: 52
    Text {
        id: orderByText
        text: qsTr("Order by:") + mytrans.emptyString
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            margins: Style.mediumOffset
        }
        color: Style.textColor
        font.pixelSize: Style.defaultTextSize
    }
    Row{ // усі варіації фільтрації
        id: orderRow
        anchors{
            left: orderByText.right
            top: parent.top
            bottom: parent.bottom
            right: ascDesc.left
        }
        spacing: Style.tinySpacing
        ListModel{
            id: model
            ListElement{listText: qsTr("None")}
            ListElement{listText: qsTr("Title")}
            ListElement{listText: qsTr("Description")}
            ListElement{listText: qsTr("State")}
            ListElement{listText: qsTr("Start")}
            ListElement{listText: qsTr("End")}
        }

        Repeater {
            model: model
            Rectangle {
                height: orderBy.height
                width: parent.width / 6 - orderRow.spacing
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
                            myModel.orderBy = "id"
                            break;
                        case 1:
                            myModel.orderBy = "Title";
                            break;
                        case 2:
                            myModel.orderBy = "Description";
                            break;
                        case 3:
                            myModel.orderBy = "State";
                            break;
                        case 4:
                            myModel.orderBy = "StartDateTime";
                            break;
                        case 5:
                            myModel.orderBy = "EndDate";
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
    Column { // прямий/обернений порядок сортування
        id: ascDesc
        anchors{
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        width: 26

        ListModel {
            id: mod
            ListElement {imgRotation: -90;}
            ListElement {imgRotation: 90;}
        }

        Repeater {
            model: mod
            Rectangle {
                height: 26
                width: 26
                color: mouseAD.containsPress ? Style.darkColor : mouseAD.containsMouse ? Qt.darker(Style.primaryColor, 1.1) : Style.primaryColor

                Image {
                    source: "qrc:/ui/assets/blue-arrow.png"
                    fillMode: Image.PreserveAspectFit
                    height: parent.height * 0.8
                    rotation: imgRotation
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    id: mouseAD
                    hoverEnabled: true
                    onClicked: {
                        switch(index){
                        case 0:
                            myModel.asc_desc = " ASC"
                            break;
                        case 1:
                            myModel.asc_desc = " DESC";
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
}
