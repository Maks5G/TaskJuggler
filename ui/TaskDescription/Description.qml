import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import StyleModule 1.0

// права частина програми із описом
Rectangle{
    id: descriptionView
    property alias title: title
    property alias description: description
    property alias btn: btn

    color: Style.backgroundColor

    Component.onCompleted: {
        title.text = "title"
        description.text = "description"
    }

    RowLayout{
        id: row
        anchors{
            right: parent.right
            left: parent.left
            top: parent.top
            margins: Style.mediumOffset
        }

        Text { text: qsTr("Title: ") + mytrans.emptyString; color: Style.textColor; font.pixelSize: Style.defaultTextSize;}
        TextField {
            id: title
            Layout.fillWidth: true // для заповнення всієї можливої ширини ряду
            background: Rectangle{
                radius: 6
                border.color: Style.borderColor
                border.width: 1
                color: Style.delegateColor
            }
            color: Style.textColor
            font.pixelSize: Style.defaultTextSize
            selectByMouse: true // щоб можна було виділити мишею текст
        }
        Image{
            id: calendarImg
            source: "qrc:/ui/assets/schedule.png"
            fillMode: Image.PreserveAspectFit
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dialogCalendar.open()
                }
            }
        }
        Button {
            id: btn
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Submit") + mytrans.emptyString
            background: Rectangle{
                radius: 6
                border.color: Style.borderColor
                border.width: 1
                color: btn.pressed ? "gray" : "white"
            }
            font.pixelSize: Style.defaultTextSize
            onClicked: { // замінюємо запис і обновляємо модель
                if(dialogCalendar.endDate){
                    database.replaceRecord(myModel.getId(tasksView.listView.currentIndex), title.text, description.text, dialogCalendar.endDate)
                } else{
                    database.replaceRecord(myModel.getId(tasksView.listView.currentIndex), title.text, description.text,
                                           myModel.getEnd(tasksView.listView.currentIndex))
                }
                myModel.updateModel()
            }
        }
    }
    ColumnLayout{
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: row.bottom
            margins: Style.mediumOffset
        }

        id: column
        Text { text: qsTr("Description: ") + mytrans.emptyString; color: Style.textColor; font.pixelSize: Style.defaultTextSize; Layout.alignment: Qt.AlignHCenter}
        TextArea{
            id: description
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: Rectangle{
                radius: 6
                border.color: Style.borderColor
                border.width: 1
                color: Style.delegateColor
            }
            color: Style.textColor
            font.pixelSize: Style.defaultTextSize
            wrapMode: TextEdit.WordWrap // для перенесення слів
            selectByMouse: true // щоб можна було виділити текст мишою
        }
    }

    DialogCalendar{
        id: dialogCalendar
    }

}
