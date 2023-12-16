#ifndef AICHAT_H
#define AICHAT_H

#include <QObject>
#include "TCPClient.h"
#include "MessageModel.h"

class AIChat : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool     isConnect       READ isConnect  WRITE setIsConnect  NOTIFY isConnectChanged)
    Q_PROPERTY(QString  userName        READ userName   WRITE setUserName   NOTIFY userNameChanged)
    Q_PROPERTY(QString  ntfMessage      READ ntfMessage WRITE setNtfMessage NOTIFY ntfMessageChanged)
    Q_PROPERTY(MessageModel* message    READ message                        NOTIFY messageChanged)
public:
    explicit AIChat(QObject *parent = nullptr);
    ~AIChat();

    bool isConnect() const;
    void setIsConnect(bool newIsConnect);

    QString userName() const;
    Q_INVOKABLE void setUserName(QString newUserName);

    QString ntfMessage() const;
    void setNtfMessage(QString newNtfMessage);

    MessageModel* message();

signals:
    void isConnectChanged();
    void userNameChanged();
    void ntfMessageChanged();
    void messageChanged();

public slots:
    void doConnect();
    void disconnect();
    void sendMessage(QString mess);

    void setIPAddress(QString ip);
    void getMessage(QString name, QString msg);

private:
    TCPClient* m_TCPClient;
    bool m_isConnect;
    QString m_userName;
    QString m_ntfMessage;
    QString m_ipAddress;
    MessageModel m_message;
};

#endif // AICHAT_H
