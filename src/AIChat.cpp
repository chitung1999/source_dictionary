#include "AIChat.h"

AIChat::AIChat(QObject *parent) : QObject(parent)
{
    m_TCPClient = new TCPClient(this);
    m_isConnect = false;
    userInfo();
    connect(m_TCPClient, SIGNAL(disconnectToSever()), this, SLOT(disconnect()));
    connect(m_TCPClient, &TCPClient::getMessage, this, &AIChat::getMessage);
}

AIChat::~AIChat()
{
    if (m_TCPClient) {
        delete m_TCPClient;
        m_TCPClient = nullptr;
    }
}

bool AIChat::isConnect() const
{
    return m_isConnect;
}

void AIChat::setIsConnect(bool newIsConnect)
{
    if (m_isConnect == newIsConnect)
        return;
    m_isConnect = newIsConnect;
    emit isConnectChanged();
}

QString AIChat::userName() const
{
    return m_userName;
}

void AIChat::setUserName(QString newUserName)
{
    if (m_userName == newUserName)
        return;
    m_userName = newUserName;
    emit userNameChanged();
    setUserInfo();
}

QString AIChat::ntfMessage() const
{
    return m_ntfMessage;

}

void AIChat::setNtfMessage(QString newNtfMessage)
{
    m_ntfMessage = newNtfMessage;
    emit ntfMessageChanged();
}

MessageModel *AIChat::message()
{
    return &m_message;
}

void AIChat::doConnect()
{
    if (m_TCPClient->getSocket()->state() == QAbstractSocket::ConnectedState) {
        qDebug() << "The client is connected to the server!";
        return;
    }

    m_TCPClient->getSocket()->connectToHost(m_ipAddress,6060);

    if (!m_TCPClient->getSocket()->waitForConnected()) {
        qDebug() << "Error: " << m_TCPClient->getSocket()->errorString();
        setNtfMessage("Không thể kết nối với máy chủ!");
        return;
    }
    setIsConnect(true);
    qDebug() << "Connected to server!";
}

void AIChat::disconnect()
{
    setIsConnect(false);
    if (m_TCPClient->getSocket()->state() == QAbstractSocket::UnconnectedState) {
        qDebug() << "The client is disconnected to the server!";
        return;
    }

    setNtfMessage("Đã ngắt kết nối với máy chủ!");
    m_TCPClient->getSocket()->disconnectFromHost();
    qDebug() << "Disconnected to server!";
}

void AIChat::sendMessage(QString mess)
{
    if (m_TCPClient->getSocket()->state() == QAbstractSocket::UnconnectedState) {
        setNtfMessage("Bạn đang Offline!");
        return;
    }
    m_TCPClient->sendMessage(m_userName, mess);
    MessageItem item(m_userName, mess, true);
    m_message.append(item);
}

void AIChat::setIPAddress(QString ip)
{
    m_ipAddress = ip;
    setUserInfo();
}

void AIChat::userInfo()
{
    QFile file(QDir::homePath() + "/Desktop/data.json");
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "Cannot open file : " << file.errorString();
        return;
    }
    QString data = file.readAll();
    file.close();

    QJsonObject jObj = QJsonDocument::fromJson(data.toUtf8()).object();
    if (!jObj.value("name").toString().isEmpty())
        m_userName = jObj.value("name").toString();
    else
        m_userName = "Admin";

    if (!jObj.value("IPAddress").toString().isEmpty())
        m_ipAddress = jObj.value("IPAddress").toString();
    else
        m_ipAddress = "127.0.0.1";

    emit userNameChanged();
}

void AIChat::setUserInfo()
{
    QFile file(QDir::homePath() + "/Desktop/data.json");
    if(!file.open(QIODevice::ReadOnly))
    {
        qDebug() << "Cannot open file : " << file.errorString();
        return;
    }
    QString data = file.readAll();
    file.close();

    QJsonObject jObj = QJsonDocument::fromJson(data.toUtf8()).object();
    jObj["name"] = m_userName;
    jObj["IPAddress"] = m_ipAddress;
    QJsonDocument jDoc(jObj);

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << "Cannot open file : " << file.errorString();
        return;
    }
    file.write(jDoc.toJson());
    file.close();
}

void AIChat::getMessage(QString name, QString msg)
{
    MessageItem item(name, msg, false);
    m_message.append(item);
}
