import QtQuick 2.15
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as Q1


Dialog{
    id: dialogCalendar
    anchors.centerIn: parent
    visible: false
    standardButtons: StandardButton.Cancel | StandardButton.Ok
    width: 480
    height: 640

    property string endDate: ""

    contentItem: Rectangle {
        Q1.Calendar{
            anchors.fill: parent
            id: calendar
        }
    }
    onAccepted: {
        endDate = calendar.selectedDate.toLocaleDateString(Qt.locale(), "dd:MM:yyyy")
    }
    onRejected: {
        endDate = ""
    }
}
