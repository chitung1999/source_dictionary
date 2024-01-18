#include "Setting.h"

Setting::Setting(QObject *parent) : QObject(parent)
{
}

void Setting::initialize(const QJsonObject &data)
{
    QString background = "";
    int lang = AppEnum::LANGUAGE::ENGLISH;
    QString themeColor = "#5ca5d1";
    QString borderColor = "#5ca5d1";

    if(!data.isEmpty()) {
        if (!data.value("background").isNull())
            background = data.value("background").toString();

        if (!data.value("themeColor").isNull())
            themeColor = data.value("themeColor").toString();

        if (!data.value("borderColor").isNull())
            borderColor = data.value("borderColor").toString();

        if (!data.value("language").toString().isEmpty()) {
            if (data.value("language").toString() == "eng")
                lang = AppEnum::LANGUAGE::ENGLISH;
            else {
                lang = AppEnum::LANGUAGE::VIETNAMESE;
            }
        }
    }

    setLanguage(lang);
    setBackground(background);
    setThemeColor(themeColor);
    setBorderColor(borderColor);
}

const int &Setting::language() const
{
    return m_language;
}

void Setting::setLanguage(const int newLanguage)
{
    if (m_language == newLanguage)
        return;
    m_language = newLanguage;
    emit languageChanged();
}

QString Setting::background() const
{
    return m_backGround;
}

void Setting::setBackground(QString newBackground)
{
    if (m_backGround == newBackground)
        return;
    m_backGround = newBackground;
    emit backgroundChanged();
}

QString Setting::themeColor() const
{
    return m_themeColor;
}

void Setting::setThemeColor(QString newThemeColor)
{
    if (m_themeColor == newThemeColor)
        return;
    m_themeColor = newThemeColor;
    emit themeColorChanged();
}

QString Setting::borderColor() const
{
    return m_borderColor;
}

void Setting::setBorderColor(QString newBorderColor)
{
    if (m_borderColor == newBorderColor)
        return;
    m_borderColor = newBorderColor;
    emit borderColorChanged();
}
