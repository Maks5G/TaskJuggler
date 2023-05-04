import QtQuick 2.15
import QtQuick.Dialogs 1.3

MessageDialog {
    id: dialogDelete
    title: qsTr("Удаление записи")
    text: qsTr("Подтвердите удаление записи из журнала")
    icon: StandardIcon.Warning
    standardButtons: StandardButton.Ok | StandardButton.Cancel

    // При положительном ответе ...
    onAccepted: {
        /* ... удаляем строку по id,
         * который забираем из модели данных
         * по номеру строки в представлении
         * */
        database.removeRecord(myModel.getId(tasksView.listView.currentIndex))
        myModel.updateModel();  // Обновляем модель данных
    }
}
