#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "tcpsever.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

   TCPSever sever;

    return app.exec();
}
