import QtQuick 6.2

Item {
    property int hour: 1
    property real itemRotation: 0.0

    width: 10
    height: 200

    transform: Rotation {
        origin.x: 0
        origin.y: 0
        angle: itemRotation
    }

    Text {
        id: number_text

        x: -t_metrics.boundingRect.width / 2
        y: 125

        text: hour
        font.family: "Helvetica"
        font.pointSize: 20
        color: "black"

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
