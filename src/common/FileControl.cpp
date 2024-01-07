#include "FileControl.h"

FileControl::FileControl()
{
}

bool FileControl::readFile(QString path, QJsonObject &data)
{
    QFile file(path);
    if(!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "Cannot open file: " << path;
        qDebug() << "Error: " << file.errorString();
        return false;
    }
    QString str = file.readAll();
    data = QJsonDocument::fromJson(str.toUtf8()).object();
    file.close();
    return true;
}

bool FileControl::writeFileJson(QString path, QJsonObject &data)
{
    QFile file(path);
    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug() << "Cannot open file: " << path;
        qDebug() << "Error: " << file.errorString();
        return false;
    }
    QJsonDocument jDoc(data);
    file.write(jDoc.toJson());
    file.close();
    return true;
}

bool FileControl::checkFileImg(QString &path)
{
    path.replace("file:///", "").replace('\\',"/");
    QFileInfo bg_img(path);
    QString extension = bg_img.suffix().toLower();
    if (bg_img.exists() && (extension == "jpg" ||
                            extension == "jpeg" || extension == "png")) {
        return true;
    }
    qDebug() << "Cann't open file: " << path;
    return false;
}
