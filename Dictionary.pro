QT += quick multimedia

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    src/common/APIRequest.cpp \
    src/common/FileControl.cpp \
    src/component/NewData.cpp \
    src/model/MeanModel.cpp \
    src/model/NoteModel.cpp \
    src/scene/Dictionary.cpp \
    src/scene/Game.cpp \
    src/scene/Grammar.cpp \
    src/scene/NoteBook.cpp \
    src/scene/Setting.cpp \
    src/Controller.cpp \
    src/main.cpp

RESOURCES += qml.qrc

TRANSLATIONS += vi_VN.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    src/common/APIRequest.h \
    src/common/FileControl.h \
    src/common/Define.h \
    src/common/AppEnum.h \
    src/component/NewData.h \
    src/model/MeanModel.h \
    src/model/NoteModel.h \
    src/scene/Dictionary.h \
    src/scene/Game.h \
    src/scene/Grammar.h \
    src/scene/NoteBook.h \
    src/scene/Setting.h \
    src/Controller.h \
