#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include "scene/NoteBook.h"
#include "scene/Dictionary.h"
#include "scene/VoiceChat.h"
#include "scene/Setting.h"
#include "common/FileControl.h"

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

     NoteBook *noteBook();
     Dictionary *dictionary();
     VoiceChat *voiceChat();
     Setting *setting();

signals:
     void notifyMsgChanged();
     void translatorChanged();

public slots:
    void setLanguage(int lang);
    void setUserName(QString name);
    void setIpAddress(QString ip);
    void setPort(int port);
    void setBackground(QString path);

    void removeItemNote(int index);
    void changeItemNote(QStringList keys, QStringList means, QString notes);

    void receiveNtf(QString ntf);

private:
    explicit Controller(QObject *parent = nullptr);

    NoteBook m_noteBook;
    Dictionary m_dictionary;
    VoiceChat m_voiceChat;
    Setting m_setting;
    QString m_notifyMsg;
    QTranslator m_translator;
    QJsonObject m_dataJson;
    FileControl m_file;
};

#endif // CONTROLLER_H
