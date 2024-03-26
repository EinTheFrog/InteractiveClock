import QtQuick 6.2
import InteractiveClock

Item {
    property int hour: 1
    property real itemRotation: 0.0
    property real clockRadius: Constants.clockRadius
    property real borderWidth: Constants.clockBorderWidth
    property real indent: 40

    transform: Rotation {
        origin.x: 0
        origin.y: 0
        angle: itemRotation
    }

    Text {
        id: number_text

        x: -t_metrics.boundingRect.width / 2
        y: clockRadius - borderWidth - indent

        text: hour
        font.family: "Helvetica"
        font.pointSize: 20
        color: Constants.clockBorderColor

        transform: Rotation {
            origin.x: t_metrics.boundingRect.width / 2
            origin.y: t_metrics.boundingRect.height / 2
            angle: -itemRotation
        }
    }

    TextMetrics {
        id:     t_metrics
        font:   number_text.font
        text:   number_text.text
    }
}
