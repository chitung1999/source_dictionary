#include "NoteBook.h"

NoteBook::NoteBook(QObject *parent) : QObject(parent)
{
    connect(&m_timer, &QTimer::timeout, this, &NoteBook::onChangedRandomKey);
    m_timer.start(10000);
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

NoteModel *NoteBook::notes()
{
    return &m_currentData;
}

NewData *NoteBook::newData()
{
    return &m_newData;
}

void NoteBook::clearData()
{
    m_data.clear();
    m_keysEng.clear();
    m_keysVn.clear();
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

const QString &NoteBook::randomKey() const
{
    return m_randomKey;
}

void NoteBook::setRandomKey(const QString &newRandomKey)
{
    if (m_randomKey == newRandomKey)
        return;
    m_randomKey = newRandomKey;
    emit randomKeyChanged();
}

void NoteBook::search(QString key, bool isENG)
{
    setCurrentKey(key);
    m_currentData.clear();
    auto it = isENG ? m_keysEng.find(key) : m_keysVn.find(key);
    foreach (auto index, it.value()) {
        m_currentData.append(m_data[index]);
    }
    emit requestSearch();
}

void NoteBook::searchChar(QString key, bool isENG)
{
    m_searchKeys.clear();

    if (key != "") {
        foreach (auto data, (isENG ? m_keysEng.keys() : m_keysVn.keys())) {
            if(data.contains(key))
                m_searchKeys.append(data);
        }
    }

    emit searchKeysChanged();
}

void NoteBook::updateData(const QJsonArray &data)
{

    clearData();
    foreach (const QJsonValue &valueObj, data) {
        NoteItem item;
        item.index = valueObj.toObject().value("index").toInt();
        QJsonArray arrWord = valueObj.toObject().value("words").toArray();
        foreach (const QJsonValue &valueWord, arrWord) {
            item.words.append(valueWord.toString());
            m_keysEng[valueWord.toString()].append(item.index);
        }

        arrWord = valueObj.toObject().value("means").toArray();
        foreach (const QJsonValue &valueWord, arrWord) {
            item.means.append(valueWord.toString());
            m_keysVn[valueWord.toString()].append(item.index);
        }

        item.notes = valueObj.toObject().value("notes").toString();

        m_data.append(item);
    }

    setKeys(m_keysEng.keys());
}

void NoteBook::updateCurrentData()
{
   m_currentData.replace(m_newData.index(), m_data[m_newData.index()]);
}

void NoteBook::onChangedRandomKey()
{
    int index = QRandomGenerator::global()->bounded(0, m_data.length());
    int indexKey = QRandomGenerator::global()->bounded(0, m_data[index].words.length());

    QString str;
    foreach (auto &value, m_data.at(index).means) {
        if (!str.isEmpty())
            str += ", ";
        str += value;
    }

    setRandomKey(m_data.at(index).words.at(indexKey) + ": " + str);
}

void NoteBook::requestModifyData(int index)
{
    m_newData.setIndex(index);
    m_newData.setIsNewData(false);
    m_newData.requestChangedData(m_data[index].words, m_data[index].means, m_data[index].notes);
    emit requestChangedData();
}

void NoteBook::requestAddNewData()
{
    m_newData.setIsNewData(true);
    m_newData.requestChangedData(QStringList(), QStringList(), QString());
    emit requestChangedData();
}

void NoteBook::requestAddItem(bool isKey, QStringList list)
{
    isKey ? m_newData.setKeys(list << "") : m_newData.setMeans(list << "");
}
