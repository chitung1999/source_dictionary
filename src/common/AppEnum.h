#ifndef APPENUM_H
#define APPENUM_H

#include <QObject>

class AppEnum : public QObject
{
    Q_OBJECT
public:
    enum APP {
        NOTEBOOK = 0,
        GRAMMAR,
        SEARCH,
        GAME,
        SETTING
    }Q_ENUMS(APP);

    enum SETTING {
        LANGUAGE = 0,
        BACKGROUND,
        COLOR
    }Q_ENUMS(SETTING);

    enum LANGUAGE {
        ENGLISH = 0,
        VIETNAMESE
    }Q_ENUMS(LANGUAGE);

    enum REMOVE {
        NOTEITEM = 0,
        GRAMMARITEM
    }Q_ENUMS(REMOVE);
};

#endif // APPENUM_H
