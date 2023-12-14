#include "Dictionary.h"

Dictionary::Dictionary(QObject *parent) : QObject(parent)
{
    connect(&m_apiRequest, &APIRequest::resultRequest, this, &Dictionary::getDataRequest, Qt::QueuedConnection);
}

const QString &Dictionary::key() const
{
    return m_key;
}

void Dictionary::setKey(const QString &newKey)
{
    if (m_key == newKey)
        return;
    m_key = newKey;
    emit keyChanged();
}

const QString &Dictionary::phonetic() const
{
    return m_phonetic;
}

void Dictionary::setPhonetic(const QString &newPhonetic)
{
    if (m_phonetic == newPhonetic)
        return;
    m_phonetic = newPhonetic;
    emit phoneticChanged();
}

const QString &Dictionary::urlAudio() const
{
    return m_urlAudio;
}

void Dictionary::setUrlAudio(const QString &newUrlAudio)
{
    if (m_urlAudio == newUrlAudio)
        return;
    m_urlAudio = newUrlAudio;
    emit urlAudioChanged();
}

const QList<QList<QString>> &Dictionary::means() const
{
    return m_means;
}

void Dictionary::setMeans(const QList<QList<QString>> &newMeans)
{
    if (m_means == newMeans)
        return;
    m_means = newMeans;
    emit meansChanged();
}

void Dictionary::search(QString key)
{
    m_apiRequest.doRequest("https://api.dictionaryapi.dev/api/v2/entries/en/" + key);
}

void Dictionary::getDataRequest(QString data)
{
    m_means.clear();
    if (data.isEmpty())
        {
            qDebug() << "Get data from Dictionary API false! ";
            return;
        }
    QJsonObject jObj = QJsonDocument::fromJson(data.toUtf8()).array().first().toObject();
    if(!jObj.isEmpty()) {
        // Key
        setKey(jObj.value("word").toString());

        // Phonetic
        QString phonetic = jObj.value("phonetic").toString();
        if(phonetic.isEmpty()) {
            foreach (QJsonValue value, jObj.value("phonetics").toArray()) {
                phonetic = value.toObject().value("text").toString();
                if(!phonetic.isEmpty())
                    break;
            }
        }
        setPhonetic(phonetic);

        // Audio
        foreach (QJsonValue value, jObj.value("phonetics").toArray()) {
            QString url = value.toObject().value("audio").toString();
            if(url != "") {
                setUrlAudio(url);
                break;
            }
        }

        foreach (QJsonValue value, jObj.value("meanings").toArray()) {
            QList<QString> listMeans;
            listMeans.append(value.toObject().value("partOfSpeech").toString());

            // Synonyms
            QString str = "";
            foreach (QJsonValue var, value.toObject().value("synonyms").toArray()) {
                str += (str != "" ? ", " : "") + var.toString();
            }
            listMeans.append(str);

            // Antonyms
            str = "";
            foreach (QJsonValue var, value.toObject().value("antonyms").toArray()) {
                str += (str != "" ? ", " : "") + var.toString();
            }
            listMeans.append(str);

            // Mean
            foreach (QJsonValue var, value.toObject().value("definitions").toArray()) {
                listMeans.append(var.toObject().value("definition").toString());
                listMeans.append(var.toObject().value("example").toString());
            }

            m_means.append(listMeans);
            emit meansChanged();
        }
    }
}
