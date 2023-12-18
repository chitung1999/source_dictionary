#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Controller.h"
#include "AppEnum.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterUncreatableType<AppEnum>("AppEnum", 1, 0, "AppEnum", "Not creatable as it is an enum type");
    engine.rootContext()->setContextProperty("CTRL", Controller::getInstance());
    engine.rootContext()->setContextProperty("NOTEBOOK", Controller::getInstance()->noteBook());
    engine.rootContext()->setContextProperty("DICTIONARY", Controller::getInstance()->dictionary());
    engine.rootContext()->setContextProperty("LISTMEAN", Controller::getInstance()->dictionary()->means());
    engine.rootContext()->setContextProperty("AICHAT", Controller::getInstance()->aiChat());
    engine.rootContext()->setContextProperty("LISTMSG", Controller::getInstance()->aiChat()->message());
    engine.rootContext()->setContextProperty("SETTING", Controller::getInstance()->setting());


    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
