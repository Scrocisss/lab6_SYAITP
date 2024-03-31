.pragma library

function getWeather(city) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                weatherData.city = response.name;
                weatherData.weather = response.weather[0].main;
                weatherData.temperature = response.main.temp;
            }
        }
    }

    var url = "https://api.openweathermap.org/data/2.5/weather?q=" + city + "&APPID=d53591817ca78fc2df369434dc339ac0";
    xhr.open("GET", url);
    xhr.send();
}

var weatherData = {
    city: "",
    weather: "",
    temperature: 0
}
