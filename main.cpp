#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "MyTreeModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MyTreeModel>("FluentUI", 1, 0, "MyTreeModel");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("untitled77", "Main");

    return app.exec();
}
