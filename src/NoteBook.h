#ifndef NOTEBOOK_H
#define NOTEBOOK_H

#include <QObject>
#include <QDir>
#include "ExcelData.h"

class NoteBook : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentKey           READ currentKey     WRITE setCurrentKey     NOTIFY currentKeyChanged)
    Q_PROPERTY(QList<QString> currentData   READ currentData    WRITE setCurrentData    NOTIFY currentDataChanged)
    Q_PROPERTY(QList<QString> allData       READ allData        WRITE setAllData       NOTIFY allDataChanged)
    Q_PROPERTY(QList<QString> searchData    READ searchData     WRITE setSearchData     NOTIFY searchDataChanged)
public:
    explicit NoteBook(QObject *parent = nullptr);

    const QString &currentKey() const;
    void setCurrentKey(const QString &newCurrentKey);

    const QList<QString> &currentData() const;
    void setCurrentData(const QList<QString> &newCurrentData);

    const QList<QString> &allData() const;
    void setAllData(const QList<QString> &newAllData);

    const QList<QString> &searchData() const;
    void setSearchData(const QList<QString> &newSearchData);

signals:
    void currentKeyChanged();
    void currentDataChanged();
    void allDataChanged();
    void searchDataChanged();
    void requestSearch();


public slots:
    void search(QString key, bool isENG);
    void searchChar(QString key, bool isENG);
    void updateData();

private:
    QString m_currentKey;
    QList<QString> m_currentData;
    QList<QString> m_allData;
    QList<QString> m_searchData;
    ExcelData m_excelData;
};

#endif // NOTEBOOK_H
