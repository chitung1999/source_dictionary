#ifndef TCPSERVER_H
#define TCPSERVER_H

#include <QObject>
#include <QDataStream>
#include <QNetworkInterface>
#include <QTcpServer>
#include <QTcpSocket>
#include <QDebug>

class TCPServer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isConnect READ isConnect WRITE setIsConnect NOTIFY isConnectChanged)
public:
    explicit TCPServer(QObject *parent = nullptr);
    ~TCPServer();

    bool isConnect() const;
    void setIsConnect(bool newIsConnect);

signals:
    void isConnectChanged();

public slots:
    QString hostAddress();
    void doConnect(int port);
    void disconnect();

private slots:
    void newConnection();
    void appendToSocketList(QTcpSocket* socket);

    void readSocket();
    void socketDisconnect();
    void socketError(QAbstractSocket::SocketError socketError);

private:
    QTcpServer* m_server;
    QSet<QTcpSocket*> m_listSocket;
    bool m_isConnect;
};

#endif // TCPSERVER_H
