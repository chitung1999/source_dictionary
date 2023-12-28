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
    explicit TCPClient(QObject *parent = nullptr);
    ~TCPClient();

    QTcpSocket *getSocket();

signals:
    void receiveMessage(QString name, QString msg);
    void sendNtfUI(QString ntf);
    void connectCompleted(bool isConnect);

public slots:
    void readSocket();
    void socketDisconnect();
    void socketError(QAbstractSocket::SocketError socketError);

    //receive slots from AIChat
    void doConnect(QString ip, int port);
    void disconnect();
    void sendMessage(QString name, QString message);

private:
    QTcpSocket* m_socket;
};

#endif // TCPCLIENT_H
