#ifndef EXCELDATA_H
#define EXCELDATA_H

#include <QObject>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QFile>
#include <QDebug>
#include <QMap>
#include "xlsxdocument.h"

using namespace QXlsx;

class ExcelData : public QObject
{
    Q_OBJECT
public:
    explicit ExcelData(QObject *parent = nullptr);

    void updateData(QString path);

    QList<QString> getCurrentData(QString key, bool isEng);
    QList<QString> getListKey();
    QList<QString> getListSearch(QString key, bool isENG);

private:
    QMap <QString, int> m_listKey_ENG;
    QMap <QString, int> m_listKey_VN;
    QList <QList<QString>> m_listData;
};

#endif // EXCELDATA_H
