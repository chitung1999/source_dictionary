#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "NoteBook.h"
#include "Dictionary.h"
#include "AIChat.h"
#include "Setting.h"

class Controller : public QObject
{
    Q_OBJECT
public:
     static Controller *getInstance();

     void initialize();

public slots:
    NoteBook *noteBook();
    Dictionary *dictionary();
    AIChat *aiChat();
    Setting *setting();

    void userInfoChanged(int changed);

private:
    explicit Controller(QObject *parent = nullptr);

    NoteBook m_noteBook;
    Dictionary m_dictionary;
    AIChat m_aiChat;
    Setting m_setting;
};

#endif // CONTROLLER_H
