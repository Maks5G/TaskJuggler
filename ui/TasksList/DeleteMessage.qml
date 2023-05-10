import QtQuick 2.15
import QtQuick.Dialogs 1.3

MessageDialog {
    id: dialogDelete
    title: qsTr("Deleting a record") + mytrans.emptyString
    text: qsTr("Confirm the deletion of the entry from the log") + mytrans.emptyString
    icon: StandardIcon.Warning
    standardButtons: StandardButton.Ok | StandardButton.Cancel

    // При позитивній відповіді ...
    onAccepted: {
        /* ... видаляємо рядок за id,
           * який вибираємо з моделей даних
           * за номером рядка у поданні
           * */
        database.removeRecord(myModel.getId(tasksView.listView.currentIndex))
        myModel.updateModel();  // Обновлюємо модель даних
    }
}
