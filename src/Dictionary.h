#ifndef DICTIONARY_H
#define DICTIONARY_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include "APIRequest.h"

class Dictionary : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString key                  READ key            WRITE setKey            NOTIFY keyChanged)
    Q_PROPERTY(QString phonetic             READ phonetic       WRITE setPhonetic       NOTIFY phoneticChanged)
    Q_PROPERTY(QString urlAudio             READ urlAudio       WRITE setUrlAudio       NOTIFY urlAudioChanged)
    Q_PROPERTY(QList<QList<QString>> means  READ means          WRITE setMeans          NOTIFY meansChanged)
public:
    explicit Dictionary(QObject *parent = nullptr);

    const QString &key() const;
    void setKey(const QString &newKey);

    const QString &phonetic() const;
    void setPhonetic(const QString &newPhonetic);

    const QString &urlAudio() const;
    void setUrlAudio(const QString &newUrlAudio);

    const QList<QList<QString>> &means() const;
    void setMeans(const QList<QList<QString>> &newMeans);


public slots:
    void search(QString key);
    void getDataRequest(QString data);

signals:
    void keyChanged();
    void phoneticChanged();
    void urlAudioChanged();
    void meansChanged();

private:
    QString m_key;
    QString m_phonetic;
    QString m_urlAudio;
    APIRequest m_apiRequest;
    QList<QList<QString>> m_means;
};

#endif // DICTIONARY_H
