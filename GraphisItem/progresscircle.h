#ifndef PROGRESSCIRCLE_H
#define PROGRESSCIRCLE_H

#include <QQuickPaintedItem>
#include <QPainter>
#include <QPen>
#include <QTimer>

class ProgressCircle : public QQuickPaintedItem
{
    Q_OBJECT
public:

    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(qreal size READ size WRITE setSize NOTIFY sizeChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(QString logo READ logoUrl WRITE setLogo NOTIFY logoChanged)

    explicit ProgressCircle(QQuickItem *parent = Q_NULLPTR);

    int value()         const {return m_value;}
    qreal size()        const {return m_size;}
    QColor color()      const {return m_color;}
    QString logoUrl()   const {return m_logoUrl;}

    void setValue(int value)    {m_value = value; if (value<0) m_timer.start();   emit valueChanged();}
    void setSize(qreal size)    {m_size = size;     emit sizeChanged();}
    void setColor(const QColor &color) {m_color = color;   emit colorChanged();}
    void setLogo(const QString &url)   {m_logoUrl = url;   emit logoChanged();}

    void paint(QPainter *painter) Q_DECL_OVERRIDE;
    QRectF boundingRect() const Q_DECL_OVERRIDE { return {QPointF(0,0), QPointF(m_size, m_size)}; }

signals:
    void valueChanged();
    void sizeChanged();
    void colorChanged();
    void logoChanged();

public slots:
    void refresh() {update(boundingRect().toRect());}

private:
    int m_value = 0;
    qreal m_size = 0;
    QColor m_color;
    QString m_logoUrl;

    QTimer m_timer;
    int m_position = 0;
};

#endif // PROGRESSCIRCLE_H
