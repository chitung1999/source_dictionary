#include "Setting.h"

Setting::Setting(QObject *parent) : QObject(parent)
{
}

void Setting::initialize(const QJsonObject &data)
{
    QString background = "";
    QString pathData = "";
    int lang = AppEnum::LANGUAGE::ENGLISH;
    bool theme = true;
    QString borderColor = "#5ca5d1";

    if(!data.isEmpty()) {
        if (!data.value("background").isNull())
            background = data.value("background").toString();

        if (!data.value("pathData").isNull())
            pathData = data.value("pathData").toString();

        if (!data.value("theme").isNull())
            theme = data.value("theme").toBool();

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
    setIsThemeLight(theme);
    setPathData(pathData);
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

QString Setting::pathData() const
{
    return m_pathData;
}

void Setting::setPathData(QString newPath)
{
    if (m_pathData == newPath)
        return;
    m_pathData = newPath;
    emit pathDataChanged();
}

bool Setting::isThemeLight() const
{
    return m_isThemeLight;
}

void Setting::setIsThemeLight(bool newtheme)
{
    if (m_isThemeLight == newtheme)
        return;
    m_isThemeLight = newtheme;
    emit isThemeLightChanged();
}
