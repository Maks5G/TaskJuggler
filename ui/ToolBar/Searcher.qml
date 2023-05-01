import QtQuick 2.15
import QtQuick.Controls 2.15

TextField{
    id: textSearch

    background: Rectangle{
        radius: 6
        border.color: "black"
        border.width: 1
        color: "#FF6868"
    }
    text: qsTr("")
    color: "black"
    placeholderText: qsTr("Enter name")
    placeholderTextColor: "#313131"
    font.pixelSize: 20
    onTextChanged: {
        //
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
