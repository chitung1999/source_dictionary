#ifndef DICTIONARY_H
#define DICTIONARY_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include "APIRequest.h"
#include "MeanModel.h"

class Dictionary : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString key                  READ key            WRITE setKey            NOTIFY keyChanged)
    Q_PROPERTY(QString phonetic             READ phonetic       WRITE setPhonetic       NOTIFY phoneticChanged)
    Q_PROPERTY(QString urlAudio             READ urlAudio       WRITE setUrlAudio       NOTIFY urlAudioChanged)
public:
    explicit Dictionary(QObject *parent = nullptr);

    const QString &key() const;
    void setKey(const QString &newKey);

    const QString &phonetic() const;
    void setPhonetic(const QString &newPhonetic);

    const QString &urlAudio() const;
    void setUrlAudio(const QString &newUrlAudio);

    MeanModel *means();

public slots:
    void search(QString key);
    void getDataRequest(QString data);

signals:
    void keyChanged();
    void phoneticChanged();
    void urlAudioChanged();

private:
    QString m_key;
    QString m_phonetic;
    QString m_urlAudio;
    APIRequest m_apiRequest;
    MeanModel m_means;
};

#endif // DICTIONARY_H
