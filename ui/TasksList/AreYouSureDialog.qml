import QtQuick 2.15
import QtQuick.Dialogs 1.3

MessageDialog {
    property int _state: -1

    id: dialogDelete
    title: qsTr("Зміна стану")
    text: qsTr("Ви впевнені?")
    icon: StandardIcon.Question
    standardButtons: StandardButton.Ok | StandardButton.Cancel

    // При положительном ответе ...
    onAccepted: {
//        database.removeRecord(myModel.getId(tasksView.listView.currentIndex))
        database.updateState(myModel.getId(tasksView.listView.currentIndex), _state);
        myModel.updateModel();  // Обновляем модель данных
    }
}
