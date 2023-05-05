import QtQuick 2.15
import QtQuick.Controls 2.15
import StyleModule 1.0

TextField{
    id: textSearch

    background: Rectangle{
        radius: 6
        border.color: Style.borderColor
        border.width: 1
        color: Style.lightColor
    }
    color: Style.textColor
    placeholderText: qsTr("Enter title")
    placeholderTextColor: Style.text2Color
    font.pixelSize: Style.defaultTextSize
    selectByMouse: true
    onTextChanged: {
        myModel.searchTask(textSearch.text);
    }
    onAccepted: {
        myModel.searchTask(textSearch.text);
    }
}

    /*Rectangle {
        anchors{
            top: root.top
            bottom: root.bottom
            right: languages.left
        }
        width: root.width / 6
        color: "white"

        TextInput {
                id: textEdit
                anchors{
                    right: parent.right
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
                wrapMode: "WordWrap"
                font.pointSize: 20
                maximumLength: 16

                property string placeholderText: "Enter text here..."

                Text {
                    text: textEdit.placeholderText
                    color: "#aaa"
                    visible: !textEdit.text
                }
            }
    }*/
