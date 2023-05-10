QT += qml quick widgets sql

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
        src/database.cpp \
        src/listmodel.cpp \
        src/timer.cpp

HEADERS += \
    src/database.h \
    src/listmodel.h \
    src/states.h \
    src/timer.h \
    src/translation/mylang.h \
    src/translation/mytranslator.h

RESOURCES += qml.qrc

TRANSLATIONS += \
    translations/TaskJuggler_uk_UA.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH = ui/

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    databases/TaskJuggler3.db
