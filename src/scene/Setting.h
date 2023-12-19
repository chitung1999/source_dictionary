#ifndef SETTING_H
#define SETTING_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include "../common/AppEnum.h"

class Setting : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int language         READ language       WRITE setLanguage       NOTIFY languageChanged)
    Q_PROPERTY(QString  userName    READ userName       WRITE setUserName       NOTIFY userNameChanged)
    Q_PROPERTY(QString  ipAddress   READ ipAddress      WRITE setIpAddress      NOTIFY ipAddressChanged)
public:
    explicit Setting(QObject *parent = nullptr);

    const int &language() const;
    Q_INVOKABLE void setLanguage(const int newLanguage);

    QString userName() const;
    Q_INVOKABLE void setUserName(QString newUserName);

    QString ipAddress() const;
    Q_INVOKABLE void setIpAddress(QString newIpAddress);

signals:
    void languageChanged(int);
    void userNameChanged(int);
    void ipAddressChanged(int);

private:
    int m_language;
    QString m_userName;
    QString m_ipAddress;
};

#endif // SETTING_H
