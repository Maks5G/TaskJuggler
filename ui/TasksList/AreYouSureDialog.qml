import QtQuick 2.15
import QtQuick.Dialogs 1.3

MessageDialog {
    property int _state: -1

    id: dialogDelete
    title: qsTr("Change of state") + mytrans.emptyString
    text: qsTr("Are you sure?") + mytrans.emptyString
    icon: StandardIcon.Question
    standardButtons: StandardButton.Ok | StandardButton.Cancel

    // При позитивній відповіді ...
    onAccepted: {
        database.updateState(myModel.getId(tasksView.listView.currentIndex), _state);
        myModel.updateModel();  // Обновлюємо модель даних
    }
}
