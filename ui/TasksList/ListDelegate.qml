import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import StyleModule 1.0
import States 1.0

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
        focus: false

        Image {
            id: icon
            source: {
                switch(tstate){
                    case States.InProccess:
                        return "qrc:/ui/assets/proccessing.png";
                    case States.Done:
                        return "qrc:/ui/assets/checked.png";
                    case States.Miss:
                        return "qrc:/ui/assets/clock.png";
                    case States.Hold:
                        return "qrc:/ui/assets/pause-button.png";
                    default:
                        break;
                }
            }
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
                Text {
                    id: title
                    color: Style.textColor
                    text: ttitle
                    font.pixelSize: Style.bigTextSize
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft
                    elide: Text.ElideRight // якщо текст не поміщається, то він частково чи повністю замінється 3 крапками
                }
                Text {
                    id: dateTimeText
                    text: tstart
                    font.pixelSize: Style.defaultTextSize
                    color: Style.textColor
                    RowLayout.alignment: Qt.AlignRight
                }
            }
            RowLayout{
                id: row2
                Text {
                    id: description
                    text: tdescription
                    Layout.fillWidth: true
                    font.pixelSize: Style.defaultTextSize
                    color: Style.text2Color
                    Layout.alignment: Qt.AlignBottom
                    elide: Text.ElideRight // якщо текст не поміщається, то він частково чи повністю замінється 3 крапками
                }
                Text {
                    id: dateText
                    text: tend
                    font.pixelSize: Style.tinyTextSize
                    color: Style.text2Color
                    RowLayout.alignment: Qt.AlignRight | Qt.AlignBottom

                }
            }
        }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.RightButton | Qt.LeftButton
            onClicked: {
                descriptionView.title.text = ttitle
                descriptionView.description.text = tdescription
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
                text: qsTr("Delete") + mytrans.emptyString
                onTriggered: {
                    /* Викликаємо діалогове вікно,
                      * яке уточнить намір
                      * */
                    dialogDelete.open()
                }
            }
        }
    }
}
