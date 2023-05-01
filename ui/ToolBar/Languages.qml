import QtQuick 2.15

Row {
    id: languages
    spacing: 4

    Image {
        id: englishIcon
        source: "qrc:/ui/assets/uk.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
    }

    Image {
        id: ukrainianIcon
        source: "qrc:/ui/assets/ukraine.png"
        fillMode: Image.PreserveAspectFit
        height: parent.height
    }

}
