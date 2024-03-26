import QtQuick 6.2

Item {  

    property int hours: 0;
    property int minutes: 0;
    property bool am: true;

    Rectangle {
        id: container

        x: -time_metrics.boundingRect.width / 2
        y: 10

        width: time_metrics.boundingRect.width
        height: time_metrics.boundingRect.height
        color: "#A0FFFFFF"

        Text {
            id: time_text

            color: "black"
            text: hours + ":" + (minutes < 10 ? "0" + minutes : minutes)
        }
        Text {
            id: am_text

            x: (time_metrics.boundingRect.width - am_metrics.boundingRect.width) / 2
            y: time_metrics.boundingRect.height

            color: "black"
            text: am ? "am" : "pm"
        }
    }

    TextMetrics {
        id:     time_metrics
        font:   time_text.font
        text:   time_text.text
    }
    TextMetrics {
        id:     am_metrics
        font:   am_text.font
        text:   am_text.text
    }
}
