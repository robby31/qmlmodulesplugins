import QtQuick 2.0
import MyComponents 1.0

EditableText {
    id: editableText
    clip: true

    property string textRole

    activeFocusOnPress: false
    selectByMouse: !readOnly

    onPressed: {
        if (delegate.ListView.isCurrentItem) {
            if (!readOnly)
                activeFocusOnPress = true
        } else {
            delegate.ListView.view.currentIndex = index
        }
    }

    text: model[textRole] ? model[textRole] : ""

    onEditingFinished: {
        if (!readOnly && text != model[textRole])
            model[textRole] = text
        focus = false
        activeFocusOnPress = false
    }
}
