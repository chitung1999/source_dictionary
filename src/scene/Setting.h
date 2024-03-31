#ifndef SETTING_H
#define SETTING_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include <QDir>
#include "../common/AppEnum.h"
#include "../common/Define.h"

class Setting : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isThemeLight    READ isThemeLight   WRITE setIsThemeLight   NOTIFY isThemeLightChanged)
    Q_PROPERTY(int language         READ language       WRITE setLanguage       NOTIFY languageChanged)
    Q_PROPERTY(QString background   READ background     WRITE setBackground     NOTIFY backgroundChanged)
    Q_PROPERTY(QString pathData     READ pathData       WRITE setPathData       NOTIFY pathDataChanged)
public:
    explicit Setting(QObject *parent = nullptr);

    void initialize(const QJsonObject &data);

    bool isThemeLight() const;
    void setIsThemeLight(bool newtheme);

    const int &language() const;
    void setLanguage(const int newLanguage);

    QString background() const;
    void setBackground(QString newBackground);

    QString pathData() const;
    void setPathData(QString newPath);

signals:
    void languageChanged();
    void backgroundChanged();
    void pathDataChanged();
    void isThemeLightChanged();

private:
    bool m_isThemeLight;
    int m_language;
    QString m_backGround;
    QString m_pathData;
};

#endif // SETTING_H
