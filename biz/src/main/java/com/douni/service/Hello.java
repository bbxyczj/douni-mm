package com.douni.service;

import com.douni.service.Obs.CurrentConditionsDisplay;
import com.douni.service.Obs.WeatherData;

/**
 * Created by jia on 2017/9/5.
 */
public class Hello {

    public static void main(String[] args) {
        WeatherData weatherData = new WeatherData();
        weatherData.setMeasurements(80, 65, 30.4f);
        weatherData.setMeasurements(82, 70, 29.2f);
        weatherData.setMeasurements(78, 90, 29.2f);


        CurrentConditionsDisplay currentConditionsDisplay = new CurrentConditionsDisplay(weatherData);
        currentConditionsDisplay.update(weatherData,"");

    }
}
