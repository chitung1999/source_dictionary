#include "Setting.h"

Setting::Setting(QObject *parent) : QObject(parent)
{
}

void Setting::initialize(const QJsonObject &data)
{
    QString ip = IP_ADDRESS;
    int port = PORT_CONENCT;
    QString name = "Admin";
    QString background = "";
    int lang = AppEnum::LANGUAGE::ENGLISH;
    if(!data.isEmpty()) {
        if (!data.value("name").toString().isEmpty())
            name = data.value("name").toString();

        if (!data.value("IPAddress").toString().isEmpty())
            ip = data.value("IPAddress").toString();

        if (!data.value("port").isNull())
            port = data.value("port").toInt();

        if (!data.value("language").toString().isEmpty()) {
            if (data.value("language").toString() == "eng")
                lang = AppEnum::LANGUAGE::ENGLISH;
            else {
                lang = AppEnum::LANGUAGE::VIETNAMESE;
            }
        }

        if (!data.value("background").isNull())
            background = data.value("background").toString();
    }

    setUserName(name);
    setIpAddress(ip);
    setLanguage(lang);
    setPort(port);
    setBackground(background);
}

const int &Setting::language() const
{
    return m_language;
}

void Setting::setLanguage(const int newLanguage)
{
    if (m_language == newLanguage)
        return;
    m_language = newLanguage;
    emit languageChanged();
}

QString Setting::userName() const
{
    return m_userName;
}

void Setting::setUserName(QString newUserName)
{
    if (m_userName == newUserName)
        return;
    m_userName = newUserName;
    emit userNameChanged();
}

QString Setting::ipAddress() const
{
    return m_ipAddress;
}

void Setting::setIpAddress(QString newIpAddress)
{
    if (m_ipAddress == newIpAddress)
        return;
    m_ipAddress = newIpAddress;
    emit ipAddressChanged();
}

QString Setting::background() const
{
    return m_backGround;
}

void Setting::setBackground(QString newBackground)
{
    if (m_backGround == newBackground)
        return;
    m_backGround = newBackground;
    emit backgroundChanged();
}

int Setting::port() const
{
    return m_port;
}

void Setting::setPort(int newPort)
{
    if (m_port == newPort)
        return;
    m_port = newPort;
    emit portChanged();
}
