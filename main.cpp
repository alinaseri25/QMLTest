#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <mybackend.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MyBackend *backend =  new MyBackend(NULL);
    // expose backend to QML
    engine.rootContext()->setContextProperty("backend", backend);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("QMLTest", "Main");

    return app.exec();
}
