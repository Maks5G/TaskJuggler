import QtQuick 2.15
import StyleModule 1.0

Row {
    id: languages
    spacing: Style.tinySpacing

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
