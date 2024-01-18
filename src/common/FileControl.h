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

    static bool readFile(QString path, QJsonObject &data);
    static bool writeFileJson(QString path, QJsonObject &data);
    static bool checkFileImg(QString &path);
};

#endif // FILECONTROL_H
