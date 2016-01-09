import QtQuick 2.3
import QtQuick.Controls 1.2

EditableDelegate {

    editor: Component {

        TextField {
            clip: true

            text: Number(styleData.value).toLocaleString(Qt.locale())

            validator: DoubleValidator {
                decimals: 2
                notation: DoubleValidator.StandardNotation
            }

            onAccepted: setData(Number.fromLocaleString(Qt.locale(), text))
        }
    }
}
