import QtQuick 6.2

Item {
    id: container

    property int hours: 0;
    property int minutes: 0;

    Rectangle {
        x: -t_metrics.boundingRect.width / 2
        y: t_metrics.boundingRect.height / 2

        width: t_metrics.boundingRect.width
        height: t_metrics.boundingRect.height
        color: "#A0FFFFFF"

        Text {
            id: time_text

            color: "black"
            text: hours + ":" + (minutes < 10 ? "0" + minutes : minutes);
        }
    }

    TextMetrics {
        id:     t_metrics
        font:   time_text.font
        text:   time_text.text
    }
}
