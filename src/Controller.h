#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QColor>
#include "scene/NoteBook.h"
#include "scene/Grammar.h"
#include "scene/Dictionary.h"
#include "scene/VoiceChat.h"
#include "scene/Setting.h"
#include "common/FileControl.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString popupNotify      READ popupNotify    WRITE setPopupNotify        NOTIFY popupNotifyChanged)
    Q_PROPERTY(QString popupConfirm     READ popupConfirm   WRITE setPopupConfirm       NOTIFY popupConfirmChanged)
    Q_PROPERTY(QString translator       READ translator                                 NOTIFY translatorChanged)
public:
     static Controller *getInstance();
     void initialize();

     QString popupNotify() const;
     void setPopupNotify(QString newPopupNotify);

     QString popupConfirm() const;
     void setPopupConfirm(QString newPopupConfirm);

     QString translator();

     NoteBook *noteBook();
     Grammar *grammar();
     Dictionary *dictionary();
     VoiceChat *voiceChat();
     Setting *setting();

signals:
     void popupNotifyChanged();
     void popupConfirmChanged();
     void translatorChanged();

public slots:
     //Setting
    void setLanguage(int lang);
    void setUserName(QString name);
    void setIpAddress(QString ip);
    void setPort(int port);
    void setBackground(QString path);
    void setThemeColor(QString color);
    void setBorderColor(QString color);

    //Notebook
    void removeItemNote();
    void changeItemNote(QStringList keys, QStringList means, QString notes);

    //Grammar
    void appendItemGrammar();
    void removeItemGrammar();
    void changedItemGrammar(int index, QString form, QString structure);

    //VoiceChat
    void doConnect();
    void disconnect();
    void sendMessage(QString msg);

    void receiveNtf(QString ntf);
    void receiveConf(int index);

private:
    explicit Controller(QObject *parent = nullptr);

    NoteBook m_noteBook;
    Grammar m_grammar;
    Dictionary m_dictionary;
    VoiceChat m_voiceChat;
    Setting m_setting;
    QString m_popupNotify;
    QString m_popupConfirm;
    QTranslator m_translator;
    QJsonObject m_dataJson;
    FileControl m_file;
    int m_indexRemove;
};

#endif // CONTROLLER_H
