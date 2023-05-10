import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as C1
import QtQuick.Layouts 1.15
import StyleModule 1.0
import QtQuick.Dialogs 1.3
import "ui/ToolBar"
import "ui/TasksList"
import "ui/TaskDescription"

ApplicationWindow {
    property int minimumSubAreaWidth: 300

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

    C1.SplitView { // controls 2 трохи некоректно працюють
        id: splitView
        z: -1
        anchors{
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            top: toolBar.bottom
        }

        handleDelegate: Rectangle {
                id: handleDelegate
                implicitWidth: 4
                implicitHeight: 4
                color: styleData.pressed ? Qt.darker(Style.lightColor, 1.1)
                    : (styleData.hovered ? Qt.lighter(Style.primaryColor, 1.1) : Style.primaryColor)

                containmentMask: Item {
                    x: (handleDelegate.width - width) / 2
                    width: 64
                    height: splitView.height
                }
            }
        Tasks {
            id: tasksView
            width: parent.width/3
            Layout.minimumWidth: minimumSubAreaWidth
            Layout.maximumWidth: parent.width * 2 / 3
            Layout.fillWidth: true
            onWidthChanged: {
                if(width >= parent.width * 2 / 3){
                    Layout.fillWidth = false
                    descriptionView.Layout.fillWidth = true
                }
            }
        }
        Description {
            id: descriptionView
            width: parent.width*2/3
            Layout.minimumWidth: minimumSubAreaWidth
            onWidthChanged: {
                if(width <= minimumSubAreaWidth){
                    Layout.fillWidth = false
                    tasksView.Layout.fillWidth = true
                }
            }
        }
    }
    AddDialog{
        id: dialog
    }
    DeleteMessage{
        id: dialogDelete
    }
    AreYouSureDialog{
        id: areYouSure
    }
}
