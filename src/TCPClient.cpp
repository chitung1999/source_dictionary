#include "TCPClient.h"

TCPClient::TCPClient(QObject *parent) : QObject(parent)
{
    m_socket = new QTcpSocket(this);
    connect(m_socket, &QTcpSocket::readyRead, this, &TCPClient::readSocket);
    connect(m_socket, &QTcpSocket::disconnected, this, &TCPClient::socketDisconnect);
    connect(m_socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(socketError(QAbstractSocket::SocketError)));
}

TCPClient::~TCPClient()
{
    m_socket->deleteLater();
    m_socket=nullptr;
}

QTcpSocket *TCPClient::getSocket()
{
    return m_socket;
}


void TCPClient::readSocket()
{
    QDataStream data(m_socket);
    QString name;
    QString message;
    data >> name >> message;
    emit getMessage(name, message);
}

void TCPClient::socketDisconnect()
{
    if(m_socket->isOpen())
        m_socket->close();
}

void TCPClient::socketError(QAbstractSocket::SocketError socketError)
{
    switch (socketError) {
    case QAbstractSocket::RemoteHostClosedError:
        qDebug() << "Remote host closed Error. Please check the host name and port settings.";
        emit disconnectToSever();
        break;
    case QAbstractSocket::HostNotFoundError:
        qDebug() <<"The host was not found. Please check the host name and port settings.";
        break;
    case QAbstractSocket::ConnectionRefusedError:
        qDebug() << "The connection was refused by the peer. Make sure QTCPServer is running, and check that the host name and port settings are correct.";
        break;
    default:
        qDebug() << "The following error occurred: " << m_socket->errorString();
        break;
    }
}

void TCPClient::sendMessage(QString name, QString data)
{
    if(m_socket && m_socket->isOpen())
    {
        QDataStream socketStream(m_socket);
        socketStream << name << data;
    }
    else
        qDebug() << "Socket doesn't seem to be opened!";
}
