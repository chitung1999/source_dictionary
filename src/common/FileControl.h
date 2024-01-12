#ifndef FILECONTROL_H
#define FILECONTROL_H

#include <QFile>
#include <QFileInfo>
#include <QString>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

class FileControl
{
public:
    FileControl();

    bool readFile(QString path, QJsonObject &data);
    bool writeFileJson(QString path, QJsonObject &data);
    bool checkFileImg(QString &path);
};

#endif // FILECONTROL_H
