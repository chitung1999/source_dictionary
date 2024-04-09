#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QMediaPlayer>
#include <QColor>
#include "scene/NoteBook.h"
#include "scene/Grammar.h"
#include "scene/Dictionary.h"
#include "scene/Game.h"
#include "scene/Setting.h"
#include "common/FileControl.h"

class Controller : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString popupNotify      READ popupNotify    WRITE setPopupNotify        NOTIFY popupNotifyChanged)
    Q_PROPERTY(QString popupConfirm     READ popupConfirm                               NOTIFY popupConfirmChanged)
    Q_PROPERTY(QString translator       READ translator                                 NOTIFY translatorChanged)
public:
     static Controller *getInstance();
     void initialize();

     QString popupNotify() const;
     void setPopupNotify(QString newPopupNotify);

     QString popupConfirm() const;

     QString translator();

     NoteBook   *noteBook();
     Grammar    *grammar();
     Dictionary *dictionary();
     Game       *game();
     Setting    *setting();

signals:
     void popupNotifyChanged();
     void popupConfirmChanged(int item, int index);
     void translatorChanged();

public slots:
     //Setting
    void setLanguage(int lang);
    void setBackground(QString path);
    void setPathData(QString path);
    void setTheme(bool isLight);

    //Notebook
    void removeItemNote(int index);
    void changeItemNote(QStringList keys, QStringList means, QString notes);
    void setPosNote(double position);

    //Grammar
    void appendItemGrammar();
    void removeItemGrammar(int index);
    void changedItemGrammar(int index, QString form, QString structure);
    void setPosGrammar(double position);

    void removeItem(int item, int index);

    void receiveNtf(QString ntf);
    void receiveConf(int item,int index);
    void receiveAudio(QString path);

private:
    explicit Controller(QObject *parent = nullptr);

    NoteBook    m_noteBook;
    Grammar     m_grammar;
    Dictionary  m_dictionary;
    Game        m_game;
    Setting     m_setting;

    QString m_popupNotify;
    QString m_popupConfirm;
    QTranslator m_translator;
    QMediaPlayer m_audio;
    QJsonObject m_dataJson;
};

#endif // CONTROLLER_H
