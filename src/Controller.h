#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include "NoteBook.h"
#include "Dictionary.h"
#include "AIChat.h"

class Controller : public QObject
{
    Q_OBJECT
public:
     static Controller *getInstance();

public slots:
    NoteBook *noteBook();
    Dictionary *dictionary();
    AIChat *aiChat();

private:
    explicit Controller(QObject *parent = nullptr);

    NoteBook m_noteBook;
    Dictionary m_dictionary;
    AIChat m_aiChat;
};

#endif // CONTROLLER_H
