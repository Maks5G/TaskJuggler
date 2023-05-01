import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as C1
import QtQuick.Layouts 1.15
import "ui/ToolBar"

ApplicationWindow {
    property int minimumSubAreaWidth: 200

    id: mainWindow
    width: 1280
    minimumWidth: 720
    minimumHeight: 480
    height: 720
    visible: true
    title: qsTr("Task Juggler")
    color: "lightgreen"

    ToolBar{
        id: toolBar
    }

    C1.SplitView {
        id: splitView
        z: -1
        anchors.fill: parent

        handleDelegate: Rectangle {
                id: handleDelegate
                implicitWidth: 4
                implicitHeight: 4
                color: styleData.pressed ? "#81e889"
                    : (styleData.hovered ? Qt.lighter("#c2f4c6", 1.1) : "#c2f4c6")

                containmentMask: Item {
                    x: (handleDelegate.width - width) / 2
                    width: 64
                    height: splitView.height
                }
            }

        Rectangle{
            id: blue
            width: parent.width/3
            Layout.minimumWidth: minimumSubAreaWidth
            Layout.maximumWidth: parent.width / 2
            Layout.fillWidth: true
            color: "lightblue"
            onWidthChanged: {
                if(width >= 600){
                    Layout.fillWidth = false
                    green.Layout.fillWidth = true
                }
            }
        }
        Rectangle{
            id: green
            width: parent.width*2/3
            Layout.minimumWidth: minimumSubAreaWidth
            color: "lightgreen"
            onWidthChanged: {
                if(width <= minimumSubAreaWidth){
                    Layout.fillWidth = false
                    blue.Layout.fillWidth = true
                }
            }
        }
    }
}
