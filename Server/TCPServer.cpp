#include "TCPServer.h"

TCPServer::TCPServer(QObject *parent) : QObject(parent)
{
    m_server = new QTcpServer();
    m_isConnect = false;
}

TCPServer::~TCPServer()
{
    foreach (QTcpSocket* socket, m_listSocket)
    {
        socket->close();
        socket->deleteLater();
    }

    m_server->close();
    m_server->deleteLater();
}

bool TCPServer::isConnect() const
{
    return m_isConnect;
}

void TCPServer::setIsConnect(bool newIsConnect)
{
    if (m_isConnect == newIsConnect)
        return;
    m_isConnect = newIsConnect;
    emit isConnectChanged();
}

void TCPServer::newConnection()
{
    while (m_server->hasPendingConnections())
        appendToSocketList(m_server->nextPendingConnection());
}

void TCPServer::appendToSocketList(QTcpSocket* socket)
{
    m_listSocket.insert(socket);
    connect(socket, &QTcpSocket::readyRead, this, &TCPServer::readSocket);
    connect(socket, &QTcpSocket::disconnected, this, &TCPServer::socketDisconnect);
    connect(socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(socketError(QAbstractSocket::SocketError)));
    qInfo()<<"New connected with IP: " << socket->peerAddress().toString() << "- Port: " << socket->peerPort();
}

void TCPServer::readSocket()
{
    QTcpSocket *socket = qobject_cast<QTcpSocket *>(sender());
    QDataStream data(socket);
    QString name;
    QString message;
    data >> name >> message;
    qDebug() << name << ": " << message;

    foreach (QTcpSocket *client_socket, m_listSocket) {
        if (client_socket != sender()) {
            QDataStream sendData(client_socket);
            sendData << name << message;
        }
    }
}

void TCPServer::socketDisconnect()
{
    QTcpSocket* socket = reinterpret_cast<QTcpSocket*>(sender());
    QSet<QTcpSocket*>::iterator it = m_listSocket.find(socket);
    if (it != m_listSocket.end()){
        qDebug() <<"A client has been disconnected with IP: " << socket->peerAddress().toString() << " - Port: " << socket->peerPort();
        m_listSocket.remove(*it);
    }

    socket->deleteLater();
}

void TCPServer::socketError(QAbstractSocket::SocketError socketError)
{
    switch (socketError) {
    case QAbstractSocket::HostNotFoundError:
        qDebug() << "The host was not found. Please check the host name and port settings.";
        break;
    case QAbstractSocket::ConnectionRefusedError:
        qDebug() << "The connection was refused by the peer. Make sure QTCPServer is running, and check that the host name and port settings are correct.";
        break;
    default:
        QTcpSocket* socket = qobject_cast<QTcpSocket*>(sender());
        qDebug() << "The following error occurred: " << socket->errorString();
        break;
    }
}

QString TCPServer::hostAddress()
{
    foreach (const QHostAddress &address, QNetworkInterface::allAddresses()) {
        if (address.protocol() == QAbstractSocket::IPv4Protocol && address != QHostAddress(QHostAddress::LocalHost))
        {
            return address.toString();
        }
    }
    return "";
}

void TCPServer::doConnect(int port)
{
    if(port == 0)
        return;

    if(m_server->listen(QHostAddress::Any, port))
    {
        connect(m_server, &QTcpServer::newConnection, this, &TCPServer::newConnection);
        setIsConnect(true);
        qDebug() << "Server started! IP: " << hostAddress() <<  "- Port: " << port;
    }
    else
    {
        qDebug() << "Unable to start the server: " << m_server->errorString();
    }
}

void TCPServer::disconnect()
{
    if (!m_server->isListening())
        return;

    foreach (QTcpSocket* socket, m_listSocket)
    {
        socket->close();
        socket->deleteLater();
    }
    m_server->close();
    setIsConnect(false);
}
