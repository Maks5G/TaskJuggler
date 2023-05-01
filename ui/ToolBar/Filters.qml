import QtQuick 2.15
import QtQuick.Layouts 1.15

Row{
    id: filterRow
    width: (root.width - tools.width - languages.width - dayAndNight.width) *7/12
    spacing: 4

    ListModel{
        id: model
        ListElement{listID: "all"; listText: qsTr("All")}
        ListElement{listID: "done"; listText: qsTr("Done")}
        ListElement{listID: "miss"; listText: qsTr("Miss")}
        ListElement{listID: "hold"; listText: qsTr("Hold")}
        ListElement{listID: "proccess"; listText: qsTr("In proccess")}
    }

    Repeater {
        model: model
        Rectangle{
            id: listID
            height: root.height
            width: parent.width / 5 - filterRow.spacing
            radius: 10
            scale: 0.9
            color: "#FF6868"
            border.color: "black"

            Text{
                width: parent.width
                anchors.centerIn: parent
                text: listText
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20
                elide: Text.ElideMiddle
            }
        }
    }
}
