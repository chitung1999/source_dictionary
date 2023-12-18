#ifndef AICHAT_H
#define AICHAT_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonObject>
#include <QThread>
#include <QDir>
#include "TCPClient.h"
#include "MessageModel.h"
#include "Define.h"

class AIChat : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool     isConnect       READ isConnect  WRITE setIsConnect  NOTIFY isConnectChanged)
    Q_PROPERTY(QString  userName        READ userName   WRITE setUserName   NOTIFY userNameChanged)
    Q_PROPERTY(QString  ntfUI           READ ntfUI      WRITE setNtfUI      NOTIFY ntfUIChanged)

public:
    explicit AIChat(QObject *parent = nullptr);
    ~AIChat();

    bool isConnect() const;
    void setIsConnect(bool newIsConnect);

    QString userName() const;
    void setUserName(QString newUserName);

    QString ntfUI() const;
    void setNtfUI(QString newNtfUI);

    MessageModel* message();

signals:
    void isConnectChanged();
    void userNameChanged();
    void ntfUIChanged();

    //request to TCPClient
    void requestConnect(QString ip);
    void requestDisconnect();
    void requestMessage(QString name, QString msg);

public slots:
    // call function from QML
    void doConnect();
    void disconnect();
    void sendMessage(QString mess);
    void setIPAddress(QString ip);

    //receive slots from TCPClient
    void receiveMessage(QString name, QString msg);
    void receiveNtf(QString ntf);
    void onConnectCompleted(bool isConnect);



private:
    TCPClient *m_TCPClient;
    QThread *m_thread;
    bool m_isConnect;
    QString m_userName;
    QString m_ntfUI;
    QString m_ipAddress;
    MessageModel m_message;
};

#endif // AICHAT_H
