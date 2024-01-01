#include "VoiceChat.h"

VoiceChat::VoiceChat(QObject *parent) : QObject(parent)
{
    m_TCPClient = new TCPClient();
    m_thread = new QThread(this);
    m_TCPClient->moveToThread(m_thread);
    m_isConnect = false;

    //request from VoiceChat to TCPClient
    connect(this, &VoiceChat::requestConnect, m_TCPClient, &TCPClient::doConnect);
    connect(this, &VoiceChat::requestDisconnect, m_TCPClient, &TCPClient::disconnect);
    connect(this, &VoiceChat::requestMessage, m_TCPClient, &TCPClient::sendMessage);

    //request from TCPClient to VoiceChat
    connect(m_TCPClient, &TCPClient::receiveMessage, this, &VoiceChat::receiveMessage);
    connect(m_TCPClient, &TCPClient::connectCompleted, this, &VoiceChat::onConnectCompleted);

    m_thread->start();
}

VoiceChat::~VoiceChat()
{
    if (m_TCPClient) {
        delete m_TCPClient;
        m_TCPClient = nullptr;
    }

    m_thread->quit();
    m_thread->wait();
}

bool VoiceChat::isConnect() const
{
    return m_isConnect;
}

void VoiceChat::setIsConnect(bool newIsConnect)
{
    if (m_isConnect == newIsConnect)
        return;
    m_isConnect = newIsConnect;
    emit isConnectChanged();
}

QString VoiceChat::userName() const
{
    return m_userName;
}

void VoiceChat::setUserName(QString newUserName)
{
    if (m_userName == newUserName)
        return;
    m_userName = newUserName;
    emit userNameChanged();
}

MessageModel *VoiceChat::message()
{
    return &m_message;
}

TCPClient *VoiceChat::tcpClient()
{
    return m_TCPClient;
}

void VoiceChat::doConnect()
{
    emit requestConnect(m_ipAddress, m_port);
}

void VoiceChat::disconnect()
{
    emit requestDisconnect();
}

void VoiceChat::sendMessage(QString mess)
{
    emit requestMessage(m_userName, mess);

    if (!m_isConnect)
        return;
    MessageItem item(m_userName, mess, true);
    m_message.append(item);
}

void VoiceChat::setIPAddress(QString ip)
{
    m_ipAddress = ip;
}

void VoiceChat::setPort(int port)
{
    m_port =port;
}

void VoiceChat::receiveMessage(QString name, QString msg)
{
    MessageItem item(name, msg, false);
    m_message.append(item);
}

void VoiceChat::onConnectCompleted(bool isConnect)
{
    setIsConnect(isConnect);
}
