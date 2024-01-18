#ifndef SETTING_H
#define SETTING_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QDebug>
#include "../common/AppEnum.h"
#include "../common/Define.h"

class Setting : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int language         READ language       WRITE setLanguage       NOTIFY languageChanged)
    Q_PROPERTY(QString background   READ background     WRITE setBackground     NOTIFY backgroundChanged)
    Q_PROPERTY(QString themeColor   READ themeColor     WRITE setThemeColor     NOTIFY themeColorChanged)
    Q_PROPERTY(QString borderColor  READ borderColor    WRITE setBorderColor    NOTIFY borderColorChanged)
public:
    explicit Setting(QObject *parent = nullptr);

    void initialize(const QJsonObject &data);

    const int &language() const;
    void setLanguage(const int newLanguage);

    QString background() const;
    void setBackground(QString newBackground);

    QString themeColor() const;
    void setThemeColor(QString newThemeColor);

    QString borderColor() const;
    void setBorderColor(QString newBorderColor);

signals:
    void languageChanged();
    void backgroundChanged();
    void themeColorChanged();
    void borderColorChanged();

private:
    int m_language;
    QString m_backGround;
    QString m_themeColor;
    QString m_borderColor;
};

#endif // SETTING_H
