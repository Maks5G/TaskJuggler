import QtQuick 2.15
import QtQuick.Controls 2.15
import StyleModule 1.0

TextField{
    id: textSearch

    background: Rectangle{
        radius: 6
        border.color: Style.borderColor
        border.width: 1
        color: Style.lightColor
    }
    color: Style.textColor
    placeholderText: qsTr("Enter title") + mytrans.emptyString
    placeholderTextColor: Style.text2Color
    font.pixelSize: Style.defaultTextSize
    selectByMouse: true // щоб можна було виділити текст мишою

    onTextChanged: {
        myModel.searchTask(textSearch.text);
    }
    onAccepted: {
        myModel.searchTask(textSearch.text);
    }
}
