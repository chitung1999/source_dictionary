#include "NoteBook.h"

NoteBook::NoteBook(QObject *parent) : QObject(parent)
{
    initialize();
}

void NoteBook::initialize()
{
    updateData();
    QVariantMap item;
    item["index"] = 0;
    item["words"] = QStringList();
    item["means"] = QStringList();
    item["notes"] = QStringList();
    m_currentData.append(item);
}

const QList<QVariantMap> &NoteBook::currentData() const
{
    return m_currentData;
}

void NoteBook::setCurrentData(const QList<QVariantMap> &newCurrentData)
{
    m_currentData = newCurrentData;
    emit currentDataChanged();
}

const QStringList &NoteBook::keys() const
{
    return m_keys;
}

void NoteBook::setKeys(const QStringList &newKeys)
{
    if (m_keys == newKeys)
        return;
    m_keys = newKeys;
    emit keysChanged();
}

const QStringList &NoteBook::searchKeys() const
{
    return m_searchKeys;
}

void NoteBook::setSearchKeys(const QStringList &newsearchKeys)
{
    if (m_searchKeys == newsearchKeys)
        return;
    m_searchKeys = newsearchKeys;
    emit searchKeysChanged();
}

const QString &NoteBook::currentKey() const
{
    return m_currentKey;
}

void NoteBook::setCurrentKey(const QString &newCurrentKey)
{
    if (m_currentKey == newCurrentKey)
        return;
    m_currentKey = newCurrentKey;
    emit currentKeyChanged();
}

void NoteBook::search(QString key, bool isENG)
{
    setCurrentKey(key);
    auto it = isENG ? m_data.keysEng.find(key) : m_data.keysVn.find(key);
    QList<QVariantMap> listdata;
    foreach (auto index, it.value()) {
        QVariantMap item;
        item["index"] = m_data.data[index].index;
        item["words"] = m_data.data[index].words;
        item["means"] = m_data.data[index].means;
        item["notes"] = m_data.data[index].notes;
        listdata.append(item);
    }
    setCurrentData(listdata);
    emit requestSearch();
}

void NoteBook::searchChar(QString key, bool isENG)
{
    m_searchKeys.clear();

    if (key != "") {
        foreach (auto data, (isENG ? m_data.keysEng.keys() : m_data.keysVn.keys())) {
            if(data.contains(key))
                m_searchKeys.append(data);
        }
    }

    emit searchKeysChanged();
}

void NoteBook::updateData()
{
    QString path = PATH_HOME + "/data.json";
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "Cannot open file: " << path;
        qDebug() << "Error: " << file.errorString();
        return;
    }
    QString data = file.readAll();
    file.close();

    m_data.clear();
    QJsonArray arr = QJsonDocument::fromJson(data.toUtf8()).array();
    foreach (const QJsonValue &valueObj, arr) {
        NoteItem item;
        item.index = valueObj.toObject().value("index").toInt();
        QJsonArray arrWord = valueObj.toObject().value("words").toArray();
        foreach (const QJsonValue &valueWord, arrWord) {
            item.words += ((item.words == "" ? "" : ", ") + valueWord.toString());
            m_data.keysEng[valueWord.toString()].append(item.index);
        }
        arrWord = valueObj.toObject().value("means").toArray();
        foreach (const QJsonValue &valueWord, arrWord) {
            item.means += ((item.means == "" ? "" : ", ") + valueWord.toString());
            m_data.keysVn[valueWord.toString()].append(item.index);
        }
        arrWord = valueObj.toObject().value("notes").toArray();
        foreach (const QJsonValue &valueWord, arrWord) {
            item.notes.append(valueWord.toString());
        }
        m_data.data.append(item);
    }

    setKeys(m_data.keysEng.keys());
}
