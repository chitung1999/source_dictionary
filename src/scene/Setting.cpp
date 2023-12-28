#include "Setting.h"

Setting::Setting(QObject *parent) : QObject(parent)
{

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
    emit languageChanged(AppEnum::NOTIFYCHANGED::LANGCHANGED);
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
    emit userNameChanged(AppEnum::NOTIFYCHANGED::NAMECHANGED);
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
    emit ipAddressChanged(AppEnum::NOTIFYCHANGED::IPCHANGED);
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
    emit portChanged(AppEnum::NOTIFYCHANGED::PORTCHANGED);
}
