import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import StyleModule 1.0

Component {
    id: delegate
    Rectangle {
        id: rect
        height: 100
        width: listView.width
        color: listView.currentIndex === index ? Style.darkColor :
               mouseArea.pressed? Style.darkColor : Style.delegateColor
        radius: Style.mediumOffset
        border.color: Style.borderColor

        Image {
            id: icon
            source: "qrc:/ui/assets/proccessing.png"
            height: parent.height * 0.75
            fillMode: Image.PreserveAspectFit
            anchors{
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                margins: Style.bigOffset
            }
        }

        ColumnLayout {
            id: column
            anchors{
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                left: icon.right
                margins: Style.bigOffset
            }
            RowLayout {
                id: row
                Layout.minimumWidth: parent.width
                Text {
                    id: title
                    color: Style.textColor
                    text: fname
                    font.pixelSize: Style.bigTextSize
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft
                    elide: Text.ElideRight
                }
                Text {
                    id: dateTime
                    text: "21:06"
                    font.pixelSize: Style.defaultTextSize
                    color: Style.textColor
                    RowLayout.alignment: Qt.AlignRight
                }
            }
            Text {
                id: description
                text: sname
                Layout.fillWidth: true
                font.pixelSize: Style.defaultTextSize
                color: Style.text2Color
                Layout.alignment: Qt.AlignBottom
                elide: Text.ElideRight
            }
        }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            onClicked: {
                descriptionView.title.text = fname
                descriptionView.description.text = sname
                listView.currentIndex = index
                listView.focus = true
                if(mouse.button == Qt.RightButton){
                    contextMenu.open();
                }
            }
        }
        Menu {
            id: contextMenu
            anchors.centerIn: parent

            MenuItem {
                text: qsTr("Удалить")
                onTriggered: {
                    /* Вызываем диалоговое окно,
                     * которое уточнит намерение удалить строку из базы данных
                     * */
                    dialogDelete.open()
                }
            }
        }
    }
}