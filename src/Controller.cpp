#include "Controller.h"

Controller::Controller(QObject *parent) : QObject(parent)
{
    initialize();

    connect(&m_setting, &Setting::userNameChanged,  this, &Controller::userInfoChanged);
    connect(&m_setting, &Setting::ipAddressChanged, this, &Controller::userInfoChanged);
    connect(&m_setting, &Setting::portChanged,      this, &Controller::userInfoChanged);
    connect(&m_setting, &Setting::languageChanged,  this, &Controller::userInfoChanged);

    connect(m_aiChat.tcpClient(),&TCPClient::sendNtfUI, this, &Controller::receiveNtf);
}

Controller *Controller::getInstance()
{
    static Controller _self;
    return &_self;
}

void Controller::initialize()
{
    QString ip = IP_ADDRESS;
    int port = PORT_CONENCT;
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

    if (!jObj.value("port").isNull())
        port = jObj.value("port").toInt();

    if (!jObj.value("language").toString().isEmpty()) {
        if (jObj.value("language").toString() == "eng")
            lang = AppEnum::LANGUAGE::ENGLISH;
        else {
            lang = AppEnum::LANGUAGE::VIETNAMESE;
            m_translator.load(PATH_HOME + "/vi_VN.qm");
            qApp->installTranslator(&m_translator);
        }
    }

    m_aiChat.setUserName(name);
    m_aiChat.setIPAddress(ip);
    m_aiChat.setPort(port);
    m_setting.setUserName(name);
    m_setting.setIpAddress(ip);
    m_setting.setLanguage(lang);
    m_setting.setPort(port);
}

QString Controller::notifyMsg() const
{
    return m_notifyMsg;
}

void Controller::setNotifyMsg(QString newNotifyMsg)
{
    m_notifyMsg = newNotifyMsg;
    emit notifyMsgChanged();
}

QString Controller::translator()
{
    return "";
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
    case AppEnum::NOTIFYCHANGED::PORTCHANGED:
        jObj["port"] = m_setting.port();
        m_aiChat.setPort(m_setting.port());
        break;
    case AppEnum::NOTIFYCHANGED::LANGCHANGED:
        switch (m_setting.language()) {
        case AppEnum::LANGUAGE::VIETNAMESE:
            jObj["language"] = "vn";
            m_translator.load(PATH_HOME + "/vi_VN.qm");
            qApp->installTranslator(&m_translator);
            break;
        case AppEnum::LANGUAGE::ENGLISH:
            jObj["language"] = "eng";
            qApp->removeTranslator(&m_translator);
            break;
        default:
            break;
        }
        emit translatorChanged();
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

void Controller::receiveNtf(QString ntf)
{
    setNotifyMsg(ntf);
}
