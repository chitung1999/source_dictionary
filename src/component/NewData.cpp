#include "NewData.h"
#include "QDebug"

NewData::NewData(QObject *parent) : QObject(parent)
{

}

const QStringList &NewData::keys() const
{
    return m_keys;
}

void NewData::setKeys(const QStringList &newKeys)
{
    m_keys = newKeys;
    emit keysChanged();
}

const QStringList &NewData::means() const
{
    return m_means;
}

void NewData::setMeans(const QStringList &newMeans)
{
    m_means = newMeans;
    emit meansChanged();
}

const QString &NewData::notes() const
{
    return m_notes;
}

void NewData::setNotes(const QString &newNotes)
{
    m_notes = newNotes;
    emit notesChanged();
}

const int &NewData::index() const
{
    return m_index;
}

void NewData::setIndex(const int &newIndex)
{
    if (m_index == newIndex)
        return;
    m_index = newIndex;
}

const bool &NewData::isNewData() const
{
    return m_isNewData;
}

void NewData::setIsNewData(const bool &isNewData)
{
    if (m_isNewData == isNewData)
        return;
    m_isNewData = isNewData;
}

void NewData::requestChangedData(QStringList listKey, QStringList listMean, QString note)
{
    setKeys(listKey << "");
    setMeans(listMean << "");
    setNotes(note);
}
