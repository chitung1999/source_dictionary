#ifndef APIREQUEST_H
#define APIREQUEST_H

#include <QThread>
#include <QDebug>
#include <QNetworkRequest>
#include <QNetworkReply>

class APIRequest : public QThread
{
    Q_OBJECT
public:
    explicit APIRequest(QObject *parent = nullptr);
        void doRequest(QString url);
        virtual void run();

     signals:
        void resultRequest(QString data);

     private:
        QString m_currentRequest;
};

#endif // APIREQUEST_H
