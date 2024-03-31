import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    property string city
    property string weather
    property real temperature

    Column {
        Text {
            text: "City: " + city
        }
        Text {
            text: "Weather: " + weather
        }
        Text {
            text: "Temperature: " + temperature
        }
    }
}
