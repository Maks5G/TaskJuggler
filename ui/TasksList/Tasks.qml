import QtQuick 2.15
import QtQuick.Layouts 1.15
import StyleModule 1.0


Rectangle{
    id: tasksView
    color: Style.backgroundColor

    Component {
        id: delegate
        Rectangle {
            id: rect
            height: 100
            width: parent.width
            color: mouseArea.pressed? Style.darkColor : Style.delegateColor
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
                onClicked: {
                    descriptionView.title.text = fname
                    descriptionView.description.text = sname
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        anchors.margins: Style.mediumOffset
        model: myModel
        spacing: Style.mediumSpacing
        delegate: delegate
    }
}
