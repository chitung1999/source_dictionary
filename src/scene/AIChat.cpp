#include "AIChat.h"

AIChat::AIChat(QObject *parent) : QObject(parent)
{
    m_TCPClient = new TCPClient();
    m_thread = new QThread(this);
    m_TCPClient->moveToThread(m_thread);
    m_isConnect = false;

    //request from AIChat to TCPClient
    connect(this, &AIChat::requestConnect, m_TCPClient, &TCPClient::doConnect);
    connect(this, &AIChat::requestDisconnect, m_TCPClient, &TCPClient::disconnect);
    connect(this, &AIChat::requestMessage, m_TCPClient, &TCPClient::sendMessage);

    //request from TCPClient to AIChat
    connect(m_TCPClient, &TCPClient::receiveMessage, this, &AIChat::receiveMessage);
    connect(m_TCPClient, &TCPClient::connectCompleted, this, &AIChat::onConnectCompleted);

    m_thread->start();
}

AIChat::~AIChat()
{
    if (m_TCPClient) {
        delete m_TCPClient;
        m_TCPClient = nullptr;
    }

    m_thread->quit();
    m_thread->wait();
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
}

MessageModel *AIChat::message()
{
    return &m_message;
}

TCPClient *AIChat::tcpClient()
{
    return m_TCPClient;
}

void AIChat::doConnect()
{
    emit requestConnect(m_ipAddress, m_port);
}

void AIChat::disconnect()
{
    emit requestDisconnect();
}

void AIChat::sendMessage(QString mess)
{
    emit requestMessage(m_userName, mess);

    if (!m_isConnect)
        return;
    MessageItem item(m_userName, mess, true);
    m_message.append(item);
}

void AIChat::setIPAddress(QString ip)
{
    m_ipAddress = ip;
}

void AIChat::setPort(int port)
{
    m_port =port;
}

void AIChat::receiveMessage(QString name, QString msg)
{
    MessageItem item(name, msg, false);
    m_message.append(item);
}

void AIChat::onConnectCompleted(bool isConnect)
{
    setIsConnect(isConnect);
}
