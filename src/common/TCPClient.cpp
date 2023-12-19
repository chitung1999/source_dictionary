#include "TCPClient.h"
#include <QThread>

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
    emit receiveMessage(name, message);
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
        emit sendNtfUI(tr("Lost connection to the server!"));
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
    emit connectCompleted(false);
}

void TCPClient::doConnect(QString ip)
{
    if (m_socket->state() == QAbstractSocket::ConnectedState) {
        qDebug() << "The client is connected to the server!";
        return;
    }

    m_socket->connectToHost(ip,6060);

    if (!m_socket->waitForConnected(4000)) {
        qDebug() << "Error: " << m_socket->errorString();
        emit sendNtfUI(tr("Can not connect to server!"));
        emit connectCompleted(false);
        return;
    }
    emit connectCompleted(true);
    qDebug() << "Connected to server!";
}

void TCPClient::disconnect()
{
    if (m_socket->state() == QAbstractSocket::UnconnectedState) {
        qDebug() << "The client is disconnected to the server!";
        return;
    }

    m_socket->disconnectFromHost();
    emit connectCompleted(false);
    emit sendNtfUI(tr("Disconnected from server!"));
    qDebug() << "Disconnected to server!";
}

void TCPClient::sendMessage(QString name, QString data)
{
    if (m_socket && m_socket->isOpen())
    {
        QDataStream socketStream(m_socket);
        socketStream << name << data;
    }
    else
    {
        qDebug() << "Socket doesn't seem to be opened!";
        emit sendNtfUI(tr("You are Offline!"));
    }
}
