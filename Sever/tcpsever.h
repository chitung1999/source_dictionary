#ifndef TCPSEVER_H
#define TCPSEVER_H

#include <QObject>
#include <QDataStream>
#include <QTcpServer>
#include <QTcpSocket>
#include <QDebug>

class TCPSever : public QObject
{
    Q_OBJECT
public:
    explicit TCPSever(QObject *parent = nullptr);
    ~TCPSever();

private slots:
    void newConnection();
    void appendToSocketList(QTcpSocket* socket);

    void readSocket();
    void socketDisconnect();
    void socketError(QAbstractSocket::SocketError socketError);
private:
    QTcpServer* m_server;
    QSet<QTcpSocket*> m_listSocket;
};

#endif // TCPSEVER_H
