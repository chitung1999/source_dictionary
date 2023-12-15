#ifndef TCPCLIENT_H
#define TCPCLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QDataStream>
#include <QDebug>

class TCPClient : public QObject
{
    Q_OBJECT
public:
    TCPClient();
    explicit TCPClient(QObject *parent = nullptr);
    ~TCPClient();

    QTcpSocket *getSocket();

signals:
    void disconnectToSever();
    void getMessage(QString msg);

public slots:
    void readSocket();
    void socketDisconnect();
    void socketError(QAbstractSocket::SocketError socketError);

    void sendMessage(QString name, QString message);

private:
    QTcpSocket* m_socket;
};

#endif // TCPCLIENT_H
