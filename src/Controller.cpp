#include "Controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    initialize();

    connect(&m_setting, &Setting::userNameChanged, this, &Controller::userInfoChanged);
    connect(&m_setting, &Setting::ipAddressChanged, this, &Controller::userInfoChanged);
    connect(&m_setting, &Setting::languageChanged, this, &Controller::userInfoChanged);
}

Controller *Controller::getInstance()
{
    static Controller _self;
    return &_self;
}

void Controller::initialize()
{
    QString ip = IP_ADDRESS;
    QString name = "Admin";
    int lang = AppEnum::LANGUAGE::ENGLISH;

    QFile file(PATH_HOME + "/data.json");
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "Cannot open file : " << file.errorString();
        return;
    }
    QString data = file.readAll();
    file.close();

    QJsonObject jObj = QJsonDocument::fromJson(data.toUtf8()).object();
    if (!jObj.value("name").toString().isEmpty())
        name = jObj.value("name").toString();

    if (!jObj.value("IPAddress").toString().isEmpty())
        ip = jObj.value("IPAddress").toString();

    if (!jObj.value("language").toString().isEmpty()) {
        if (jObj.value("language").toString() == "eng")
            lang = AppEnum::LANGUAGE::ENGLISH;
        else
            lang = AppEnum::LANGUAGE::VIETNAMESE;
    }

    m_aiChat.setUserName(name);
    m_aiChat.setIPAddress(ip);
    m_setting.setUserName(name);
    m_setting.setIpAddress(ip);
    m_setting.setLanguage(lang);
}

NoteBook *Controller::noteBook()
{
    return &m_noteBook;
}

Dictionary *Controller::dictionary()
{
    return &m_dictionary;
}

AIChat *Controller::aiChat()
{
    return &m_aiChat;
}

Setting *Controller::setting()
{
    return &m_setting;
}

void Controller::userInfoChanged(int changed)
{
    QFile file(PATH_HOME + "/data.json");
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "Cannot open file : " << file.errorString();
        return;
    }
    QString data = file.readAll();
    file.close();

    QJsonObject jObj = QJsonDocument::fromJson(data.toUtf8()).object();

    switch (changed) {
    case AppEnum::NOTIFYCHANGED::IPCHANGED:
        jObj["IPAddress"] = m_setting.ipAddress();
        m_aiChat.setIPAddress(m_setting.ipAddress());
        break;
    case AppEnum::NOTIFYCHANGED::NAMECHANGED:
        jObj["name"] = m_setting.userName();
        m_aiChat.setUserName(m_setting.userName());
        break;
    case AppEnum::NOTIFYCHANGED::LANGCHANGED:
        jObj["language"] = (m_setting.language() == AppEnum::LANGUAGE::ENGLISH ? "eng" : "vn");
        break;
    default:
        break;
    }

    QJsonDocument jDoc(jObj);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << "Cannot open file : " << file.errorString();
        return;
    }
    file.write(jDoc.toJson());
    file.close();
}
