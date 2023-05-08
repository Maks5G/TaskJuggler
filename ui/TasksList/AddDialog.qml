import QtQuick 2.15
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.15
import StyleModule 1.0
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.1
import States 1.0
import QtQuick.Controls 1.4 as Q1
import "../TaskDescription"


Dialog{
    anchors.centerIn: parent
    id: dialog
    width: 800
    height: 600
    standardButtons: StandardButton.Cancel | StandardButton.Ok
    RowLayout{
        id: row
        anchors{
            right: parent.right
            left: parent.left
            top: parent.top
            margins: Style.mediumOffset
        }

        Text { text: qsTr("Title: "); font.pixelSize: Style.defaultTextSize;}
        TextField {
            id: title
            Layout.fillWidth: true
            background: Rectangle{
                radius: 6
                border.width: 1
            }
            font.pixelSize: Style.defaultTextSize
            selectByMouse: true
            placeholderText: qsTr("Required field")
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
        Text { text: qsTr("Description: "); font.pixelSize: Style.defaultTextSize; Layout.alignment: Qt.AlignHCenter}
        TextArea{
            id: description
            Layout.fillHeight: true
            Layout.fillWidth: true
            background: Rectangle{
                radius: 6
                border.width: 1
            }
            font.pixelSize: Style.defaultTextSize
            wrapMode: TextEdit.WordWrap
            selectByMouse: true
        }
    }

    DialogCalendar {
        id: dialogCalendar
    }

    onAccepted: {
        if(title.text.length > 0){
            var date = new Date();
            if(dialogCalendar.endDate){
                database.insertIntoTable(title.text , description.text, States.InProccess, date.toLocaleString(Qt.locale(), Locale.ShortFormat),
                                         dialogCalendar.endDate)
            } else {
                database.insertIntoTable(title.text , description.text, States.InProccess, date.toLocaleString(Qt.locale(), Locale.ShortFormat),
                                         "limitless")
            }
            myModel.updateModel() // И обновляем модель данных с новой записью
            title.text = ""
            description.text = ""
        }
    }
    onRejected: {
        title.text = ""
        description.text = ""
    }
}
