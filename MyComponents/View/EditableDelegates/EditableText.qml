import QtQuick 2.5
import QtQuick.Controls 2.1

TextField {
    id: item
    width: 200

    selectByMouse: true

    background: Rectangle {
        color: item.focus ? "white" : "transparent"
        border.color: item.focus ? "#21be2b" : "transparent"
    }
}
