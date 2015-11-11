#ifndef MYQMLMODULES_H
#define MYQMLMODULES_H

#include <QQuickItem>

class MyQmlModules : public QQuickItem
{
    Q_OBJECT
    Q_DISABLE_COPY(MyQmlModules)

public:
    MyQmlModules(QQuickItem *parent = 0);
    ~MyQmlModules();
};

#endif // MYQMLMODULES_H

