#ifndef NEWDATA_H
#define NEWDATA_H

#include <QObject>

class NewData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList keys     READ keys           WRITE setKeys           NOTIFY keysChanged)
    Q_PROPERTY(QStringList means    READ means          WRITE setMeans          NOTIFY meansChanged)
    Q_PROPERTY(QString notes        READ notes          WRITE setNotes          NOTIFY notesChanged)
public:
    explicit NewData(QObject *parent = nullptr);

    const QStringList &keys() const;
    void setKeys(const QStringList &newKeys);

    const QStringList &means() const;
    void setMeans(const QStringList &newMeans);

    const QString &notes() const;
    void setNotes(const QString &newNotes);

    const int &index() const;
    void setIndex(const int &newIndex);

    const bool &isNewData() const;
    void setIsNewData(const bool &isNewData);

    void requestChangedData(QStringList listKey, QStringList listMean , QString note);

signals:
    void keysChanged();
    void meansChanged();
    void notesChanged();

public slots:

private:
    QStringList m_keys;
    QStringList m_means;
    QString m_notes;
    int m_index;
    bool m_isNewData;
};

#endif // NEWDATA_H
