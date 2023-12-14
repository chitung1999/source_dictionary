#ifndef APPENUM_H
#define APPENUM_H

#include <QObject>

class AppEnum : public QObject
{
    Q_OBJECT
    Q_ENUMS(APP)
public:
    enum APP {
        NOTEBOOK = 0,
        SEARCH,
        AICHAT,
        GAME
    };
};

#endif // APPENUM_H
