#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <mybackend.h>
#include <mylistmodel.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    MyBackend *backend =  new MyBackend(nullptr);
    MyListModel *listModel = new MyListModel(nullptr);

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("backend", backend);

    engine.rootContext()->setContextProperty("listModel", listModel);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("QMLTest", "Main");

    return app.exec();
}
