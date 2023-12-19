#include "APIRequest.h"

APIRequest::APIRequest(QObject *parent) : QThread(parent)
{
}

void APIRequest::doRequest(QString url)
{
    m_currentRequest = url;
    this->start();
}

void APIRequest::run()
{
    QNetworkAccessManager *manager = new QNetworkAccessManager();
    manager->moveToThread(this);
    connect(manager, &QNetworkAccessManager::finished,
            [=](QNetworkReply*r){
        QString data = QString(r->readAll());
        emit resultRequest(data);
        this->quit();
        manager->deleteLater();
    });
    QNetworkRequest request;
    request.setUrl(QUrl(m_currentRequest));
    manager->get(request);
    this->exec();
}
