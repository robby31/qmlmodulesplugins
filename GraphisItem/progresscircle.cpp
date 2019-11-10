#include "progresscircle.h"

ProgressCircle::ProgressCircle(QQuickItem *parent) :
    QQuickPaintedItem(parent)
{
    connect(&m_timer, SIGNAL(timeout()), this, SLOT(refresh()));
    m_timer.setInterval(10);
}

void ProgressCircle::paint(QPainter *painter)
{
    QPen pen(m_color, 1);
    QLinearGradient grad(0,0,0,boundingRect().height());
    grad.setColorAt(0, Qt::lightGray);
    grad.setColorAt(1, Qt::gray);

    painter->setFont(QFont("Times", 12, QFont::Bold));
    painter->setRenderHints(QPainter::Antialiasing, true);

    painter->setPen(QPen(QColor(33,33,33)));
    painter->setBrush(QBrush(Qt::black));
    painter->drawEllipse(QPointF(m_size/2,m_size/2),m_size/2-1,m_size/2-1);

    painter->setPen(pen);
    painter->setBrush(QBrush(m_color));

    if (m_value>=0)
        painter->drawPie(boundingRect(),90*16, static_cast<int>(3.6*16)*-m_value);
    else
    {
        painter->drawPie(boundingRect(), -m_position*16, static_cast<int>(3.6*16*10));
        m_position = m_position%360;
        ++m_position;
    }

    painter->setPen(QPen(Qt::gray));
    painter->setBrush(QBrush(grad));
    painter->drawEllipse(QPointF(m_size/2,m_size/2),m_size/2.6,m_size/2.6);

    painter->setPen(QPen(QColor(33,33,33)));
    painter->setBrush(QBrush(Qt::black));
    painter->drawEllipse(QPointF(m_size/2,m_size/2),m_size/3.2,m_size/3.2);

    painter->setPen(QPen(Qt::white));

    if (m_value>=0)
    {
        painter->drawText(boundingRect(), Qt::AlignCenter, QString::number(m_value)+"%");
    }
    else if (!m_logoUrl.isEmpty())
    {
        QPixmap p = QPixmap(m_logoUrl).scaled(static_cast<int>(m_size/2),static_cast<int>(m_size/2),Qt::KeepAspectRatio,Qt::SmoothTransformation);
        painter->drawPixmap(QPointF(m_size/4, (boundingRect().height()-p.rect().height())/2), p);
    }
}
