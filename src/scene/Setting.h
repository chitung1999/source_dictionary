#ifndef SETTING_H
#define SETTING_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFileInfo>
#include <QDebug>
#include "../common/AppEnum.h"
#include "../common/Define.h"

class Setting : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int language         READ language       WRITE setLanguage       NOTIFY languageChanged)
    Q_PROPERTY(int port             READ port           WRITE setPort           NOTIFY portChanged)
    Q_PROPERTY(QString userName     READ userName       WRITE setUserName       NOTIFY userNameChanged)
    Q_PROPERTY(QString ipAddress    READ ipAddress      WRITE setIpAddress      NOTIFY ipAddressChanged)
    Q_PROPERTY(QString background   READ background     WRITE setBackground     NOTIFY backgroundChanged)
public:
    explicit Setting(QObject *parent = nullptr);

    void initialize(const QJsonObject &data);

    const int &language() const;
    void setLanguage(const int newLanguage);

    QString userName() const;
    void setUserName(QString newUserName);

    QString ipAddress() const;
    void setIpAddress(QString newIpAddress);

    QString background() const;
    void setBackground(QString newBackground);

    int port() const;
    void setPort(int newPort);

signals:
    void languageChanged();
    void userNameChanged();
    void ipAddressChanged();
    void portChanged();
    void backgroundChanged();

private:
    int m_language;
    int m_port;
    QString m_userName;
    QString m_ipAddress;
    QString m_backGround;
};

#endif // SETTING_H
