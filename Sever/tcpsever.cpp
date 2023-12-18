#include "tcpsever.h"

TCPSever::TCPSever(QObject *parent) : QObject(parent)
{
    m_server = new QTcpServer();

    if(m_server->listen(QHostAddress::Any, 6060))
    {
        connect(m_server, &QTcpServer::newConnection, this, &TCPSever::newConnection);
        qDebug() << "Server started on port 6060";
    }
    else
    {
        qDebug() << "Unable to start the server: " << m_server->errorString();
        exit(EXIT_FAILURE);
    }
}

TCPSever::~TCPSever()
{
    foreach (QTcpSocket* socket, m_listSocket)
    {
        socket->close();
        socket->deleteLater();
    }

    m_server->close();
    m_server->deleteLater();
}

void TCPSever::newConnection()
{
    while (m_server->hasPendingConnections())
        appendToSocketList(m_server->nextPendingConnection());
}

void TCPSever::appendToSocketList(QTcpSocket* socket)
{
    m_listSocket.insert(socket);
    connect(socket, &QTcpSocket::readyRead, this, &TCPSever::readSocket);
    connect(socket, &QTcpSocket::disconnected, this, &TCPSever::socketDisconnect);
    connect(socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(socketError(QAbstractSocket::SocketError)));
    qInfo()<<"New connected with IP: " << socket->peerAddress().toString() << "- Port: " << socket->peerPort();
}

void TCPSever::readSocket()
{
     QTcpSocket *socket = qobject_cast<QTcpSocket *>(sender());
     QDataStream data(socket);
     QString name;
     QString message;
     data >> name >> message;

    foreach (QTcpSocket *client_socket, m_listSocket) {
        if (client_socket != sender()) {
            QDataStream sendData(client_socket);
            sendData << name << message;
        }
    }
}

void TCPSever::socketDisconnect()
{
    QTcpSocket* socket = reinterpret_cast<QTcpSocket*>(sender());
    QSet<QTcpSocket*>::iterator it = m_listSocket.find(socket);
    if (it != m_listSocket.end()){
        qDebug() <<"A client has been disconnected with IP: " << socket->peerAddress().toString() << " - Port: " << socket->peerPort();
        m_listSocket.remove(*it);
    }

    socket->deleteLater();
}

void TCPSever::socketError(QAbstractSocket::SocketError socketError)
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
