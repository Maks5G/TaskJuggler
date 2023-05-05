import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import StyleModule 1.0

Rectangle{
    id: descriptionView
    property alias title: title
    property alias description: description
    property alias btn: btn

    color: Style.backgroundColor
    RowLayout{
        id: row
        anchors{
            right: parent.right
            left: parent.left
            top: parent.top
            margins: Style.mediumOffset
        }

        Text { text: qsTr("Title: "); color: Style.textColor; font.pixelSize: Style.defaultTextSize;}
        TextField {
            id: title
            Layout.fillWidth: true
            background: Rectangle{
                radius: 6
                border.color: Style.borderColor
                border.width: 1
                color: Style.delegateColor
            }
            color: Style.textColor
            font.pixelSize: Style.defaultTextSize
            selectByMouse: true
        }
        Button {
            id: btn
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Submit")
            background: Rectangle{
                radius: 6
                border.color: Style.borderColor
                border.width: 1
                color: btn.pressed ? "gray" : "white"
            }
            font.pixelSize: Style.defaultTextSize
            onClicked: {
                database.replaceRecord(myModel.getId(tasksView.listView.currentIndex), title.text, description.text)
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
        Text { text: qsTr("Description: "); color: Style.textColor; font.pixelSize: Style.defaultTextSize; Layout.alignment: Qt.AlignHCenter}
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
            wrapMode: TextEdit.WordWrap
            selectByMouse: true
        }
    }

}
