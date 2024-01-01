#ifndef NOTEBOOK_H
#define NOTEBOOK_H

#include <QObject>
#include <QDir>
#include <QMap>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include "../common/Define.h"

struct NoteItem {
    NoteItem(){}
    NoteItem(int i, QString w, QString m, QStringList n) {
        index = i;
        words = w;
        means = m;
        notes = n;
    }
    int index;
    QString words;
    QString means;
    QStringList notes;
};

struct Data {
    QList<NoteItem> data;
    QMap <QString, QList<int>> keysEng;
    QMap <QString, QList<int>> keysVn;

    void clear() {
        data.clear();
        keysEng.clear();
        keysVn.clear();
    }
};

class NoteBook : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentKey               READ currentKey     WRITE setCurrentKey     NOTIFY currentKeyChanged)
    Q_PROPERTY(QStringList keys                 READ keys           WRITE setKeys           NOTIFY keysChanged)
    Q_PROPERTY(QStringList searchKeys           READ searchKeys     WRITE setSearchKeys     NOTIFY searchKeysChanged)
    Q_PROPERTY(QList<QVariantMap> currentData   READ currentData    WRITE setCurrentData    NOTIFY currentDataChanged)
public:
    explicit NoteBook(QObject *parent = nullptr);
    void initialize();

    const QString &currentKey() const;
    void setCurrentKey(const QString &newCurrentKey);

    const QList<QVariantMap> &currentData() const;
    void setCurrentData(const QList<QVariantMap> &newCurrentData);

    const QStringList &keys() const;
    void setKeys(const QStringList &newKeys);

    const QStringList &searchKeys() const;
    void setSearchKeys(const QStringList &newsearchKeys);

signals:
    void currentKeyChanged();
    void currentDataChanged();
    void keysChanged();
    void searchKeysChanged();
    void requestSearch();

public slots:
    void search(QString key, bool isENG);
    void searchChar(QString key, bool isENG);
    void updateData();

private:
    QString m_currentKey;
    QList<QVariantMap> m_currentData;
    QStringList m_keys;
    QStringList m_searchKeys;
    Data m_data;
};

#endif // NOTEBOOK_H
