#ifndef MYQMLMODULES_H
#define MYQMLMODULES_H

#include <QQuickItem>

class MyQmlModules : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(MyQmlModules)

public:
    MyQmlModules(QQuickItem *parent = Q_NULLPTR);
    ~MyQmlModules() Q_DECL_OVERRIDE = default;
};

#endif // MYQMLMODULES_H

