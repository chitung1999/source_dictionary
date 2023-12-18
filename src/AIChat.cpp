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
    connect(m_TCPClient, &TCPClient::sendNtfUI, this, &AIChat::receiveNtf);

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

QString AIChat::ntfUI() const
{
    return m_ntfUI;

}

void AIChat::setNtfUI(QString newNtfUI)
{
    m_ntfUI = newNtfUI;
    emit ntfUIChanged();
}

MessageModel *AIChat::message()
{
    return &m_message;
}

void AIChat::doConnect()
{
    emit requestConnect(m_ipAddress);
}

void AIChat::disconnect()
{
    emit requestDisconnect();
}

void AIChat::sendMessage(QString mess)
{
    if (!m_isConnect) {
        setNtfUI("Bạn đang Offline!");
        return;
    }

    emit requestMessage(m_userName, mess);
    MessageItem item(m_userName, mess, true);
    m_message.append(item);
}

void AIChat::setIPAddress(QString ip)
{
    m_ipAddress = ip;
}

void AIChat::receiveMessage(QString name, QString msg)
{
    MessageItem item(name, msg, false);
    m_message.append(item);
}

void AIChat::receiveNtf(QString ntf)
{
    setNtfUI(ntf);
}

void AIChat::onConnectCompleted(bool isConnect)
{
    setIsConnect(isConnect);
}
