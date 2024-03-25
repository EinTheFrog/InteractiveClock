import QtQuick 6.2

Item {
    id: container

    property int hours: 0;
    property int minutes: 0;

    Rectangle {
        x: -t_metrics.boundingRect.width / 2
        y: t_metrics.boundingRect.height / 2

        color: "#A0FFFFFF"

        Text {
            id: time_text

            color: "black"
            text: hours + ":" + minutes
        }
    }

    TextMetrics {
        id:     t_metrics
        font:   time_text.font
        text:   time_text.text
    }
}
