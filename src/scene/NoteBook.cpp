#include "NoteBook.h"

NoteBook::NoteBook(QObject *parent) : QObject(parent)
{
    m_currentKey = "";
    for (int i = 0; i < 12; i++)
        m_currentData.append("");
    updateData();
}

const QList<QString> &NoteBook::currentData() const
{
    return m_currentData;
}

void NoteBook::setCurrentData(const QList<QString> &newCurrentData)
{
    if (m_currentData == newCurrentData)
        return;
    m_currentData = newCurrentData;
    emit currentDataChanged();
}

const QList<QString> &NoteBook::allData() const
{
    return m_allData;
}

void NoteBook::setAllData(const QList<QString> &newAllData)
{
    if (m_allData == newAllData)
        return;
    m_allData = newAllData;
    emit allDataChanged();
}

const QList<QString> &NoteBook::searchData() const
{
    return m_searchData;
}

void NoteBook::setSearchData(const QList<QString> &newSearchData)
{
    if (m_searchData == newSearchData)
        return;
    m_searchData = newSearchData;
    emit searchDataChanged();
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
    setCurrentData(m_excelData.getCurrentData(key, isENG));
    emit requestSearch();
}

void NoteBook::searchChar(QString key, bool isENG)
{
    if (key == "") {
        m_searchData.clear();
        emit searchDataChanged();
        return;
    }
    setSearchData(m_excelData.getListSearch(key, isENG));
}

void NoteBook::updateData()
{
    m_excelData.updateData(PATH_HOME + "/data.xlsx");
//    m_excelData.updateData(QDir::currentPath() + "/data.xlsx");
    setAllData(m_excelData.getListKey());
}

