//
//  ForecastResponse.swift
//  WheatherApp
//
//  Created by Enrico Sousa Gollner on 04/03/24.
//

import Foundation

// MARK: - ForecastResponse
struct ForecastResponse: Codable {
    let current: Forecast
    let hourly: [Forecast]
    let DailyForecast: [DailyForecast]
    let moonPhase: String

    enum CodingKeys: String, CodingKey {
        case current, hourly, DailyForecast
        case moonPhase = "moon_phase"
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let dt: Int
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, temp, humidity, weather
        case windSpeed = "wind_speed"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}
