
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral(u"qrc:/WeatherApp_v1/Main.qml"));
    engine.load(url);

    return app.exec();
}
