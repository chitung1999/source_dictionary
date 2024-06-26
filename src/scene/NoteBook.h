#ifndef NOTEBOOK_H
#define NOTEBOOK_H

#include <QObject>
#include <QDir>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include <QTimer>
#include <QRandomGenerator>
#include "../common/Define.h"
#include "../model/NoteModel.h"
#include "../component/NewData.h"

class NoteBook : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentKey               READ currentKey     WRITE setCurrentKey     NOTIFY currentKeyChanged)
    Q_PROPERTY(QString randomKey                READ randomKey      WRITE setRandomKey      NOTIFY randomKeyChanged)
    Q_PROPERTY(double posScroll                 READ posScroll      WRITE setPosScroll    NOTIFY posScrollChanged)
    Q_PROPERTY(QStringList keys                 READ keys           WRITE setKeys           NOTIFY keysChanged)
    Q_PROPERTY(QStringList searchKeys           READ searchKeys     WRITE setSearchKeys     NOTIFY searchKeysChanged)
public:
    explicit NoteBook(QObject *parent = nullptr);

    const QString &currentKey() const;
    void setCurrentKey(const QString &newCurrentKey);

    const QString &randomKey() const;
    void setRandomKey(const QString &newRandomKey);

    const double &posScroll() const;
    void setPosScroll(const double newPosScroll);

    const QStringList &keys() const;
    void setKeys(const QStringList &newKeys);

    const QStringList &searchKeys() const;
    void setSearchKeys(const QStringList &newsearchKeys);

    NoteModel *notes();
    NewData *newData();

    void clearData();

signals:
    void currentKeyChanged();
    void randomKeyChanged();
    void currentDataChanged();
    void posScrollChanged();
    void keysChanged();
    void searchKeysChanged();
    void requestSearch();
    void requestChangedData();
    //send to Game
    void sendQuestion(QString, QString);


public slots:
    void search(QString key, bool isENG);
    void searchChar(QString key, bool isENG);
    void updateData(const QJsonArray &data);
    void updateCurrentData();
    void onChangedRandomKey();
    void popupModifyData(int index);
    void popupAddNewData();
    void popupAddItem(bool isKey, QStringList list);
    //request from Game
    void onRequestQuestion();

private:
    double m_posScroll;
    QString m_currentKey;
    QString m_randomKey;
    QStringList m_keys;
    QStringList m_searchKeys;
    NoteModel m_currentData;
    NewData m_newData;
    QList <NoteItem> m_data;
    QMap <QString, QList<int>> m_keysEng;
    QMap <QString, QList<int>> m_keysVn;
    QTimer m_timer;
};

#endif // NOTEBOOK_H
