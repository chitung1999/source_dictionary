#include "ExcelData.h"

ExcelData::ExcelData(QObject *parent) : QObject(parent)
{
}

void ExcelData::updateData(QString path)
{
    Document data(path);
    if (!data.load()) {
        qDebug() << "Cann't open file Excel: " << path;
        return;
    }

    m_listKey_ENG.clear();
    m_listKey_VN.clear();
    m_listData.clear();
    int row = 4;
    do {
        QList <QString> listData;
        for (int col = 1; col < 13; col++) {
            QString cell = data.read(row, col).toString();
            listData.append(cell);
            if(col < 9 && cell != "")
                m_listKey_ENG[cell] = row;
            if(col >= 9 && cell != "")
                m_listKey_VN[cell] = row;
        }
        m_listData.append(listData);
        row++;
    } while (data.read( row, 1).toString() != "");
}

QList<QString> ExcelData::getCurrentData(QString key, bool isENG)
{
    auto it = isENG ? m_listKey_ENG.find(key) : m_listKey_VN.find(key);
    return m_listData[it.value() - 4];
}

QList<QString> ExcelData::getListKey()
{
    return m_listKey_ENG.keys();
}

QList<QString> ExcelData::getListSearch(QString key , bool isENG)
{
    QList<QString> listData;
    foreach (auto data, isENG ? m_listKey_ENG.keys() : m_listKey_VN.keys()) {
        if(data.contains(key))
            listData.append(data);
    }
    return listData;
}
