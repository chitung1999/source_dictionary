#include "Controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
}

Controller *Controller::getInstance()
{
    static Controller _self;
    return &_self;
}

NoteBook *Controller::noteBook()
{
    return &m_noteBook;
}

Dictionary *Controller::dictionary()
{
    return &m_dictionary;
}
