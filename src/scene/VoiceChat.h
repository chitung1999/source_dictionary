#ifndef VOICECHAT_H
#define VOICECHAT_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QThread>
#include <QDir>
#include "../common/TCPClient.h"
#include "../common/Define.h"
#include "../model/MessageModel.h"

class VoiceChat : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool     isConnect       READ isConnect  WRITE setIsConnect  NOTIFY isConnectChanged)

public:
    explicit VoiceChat(QObject *parent = nullptr);
    ~VoiceChat();

    bool isConnect() const;
    void setIsConnect(bool newIsConnect);

    void doConnect(QString ip, int port);
    void disconnect();
    void sendMessage(QString name, QString msg);

    MessageModel* message();
    TCPClient *tcpClient();

signals:
    void isConnectChanged();

    //request to TCPClient
    void requestConnect(QString ip, int port);
    void requestDisconnect();
    void requestSendMessage(QString name, QString msg);

public slots:
    //receive slots from TCPClient
    void receiveMessage(QString name, QString msg);
    void onConnectCompleted(bool isConnect);



private:
    TCPClient *m_TCPClient;
    QThread *m_thread;
    bool m_isConnect;
    QString m_ntfUI;
    MessageModel m_message;
};

#endif // VOICECHAT_H
