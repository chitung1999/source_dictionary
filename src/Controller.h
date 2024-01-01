#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include "scene/NoteBook.h"
#include "scene/Dictionary.h"
#include "scene/VoiceChat.h"
#include "scene/Setting.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString notifyMsg    READ notifyMsg  WRITE setNotifyMsg  NOTIFY notifyMsgChanged)
    Q_PROPERTY(QString translator   READ translator                     NOTIFY translatorChanged)
public:
     static Controller *getInstance();
     void initialize();

     QString notifyMsg() const;
     void setNotifyMsg(QString newNotifyMsg);

     QString translator();

signals:
     void notifyMsgChanged();
     void translatorChanged();

public slots:
    NoteBook *noteBook();
    Dictionary *dictionary();
    VoiceChat *voiceChat();
    Setting *setting();

    void userInfoChanged(int changed);
    void receiveNtf(QString ntf);

private:
    explicit Controller(QObject *parent = nullptr);

    NoteBook m_noteBook;
    Dictionary m_dictionary;
    VoiceChat m_voiceChat;
    Setting m_setting;

    QString m_notifyMsg;
    QTranslator m_translator;
};

#endif // CONTROLLER_H
