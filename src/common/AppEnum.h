#ifndef APPENUM_H
#define APPENUM_H

#include <QObject>

class AppEnum : public QObject
{
    Q_OBJECT
public:
    enum APP {
        NOTEBOOK = 0,
        SEARCH,
        AICHAT,
        SETTING
    }Q_ENUMS(APP);

    enum SETTING {
        LANGUAGE = 0,
        USERNAME,
        CONNECT
    }Q_ENUMS(SETTING);

    enum LANGUAGE {
        ENGLISH = 0,
        VIETNAMESE
    }Q_ENUMS(LANGUAGE);

    enum NOTIFYCHANGED {
        LANGCHANGED = 0,
        NAMECHANGED,
        IPCHANGED
    };
};

#endif // APPENUM_H
