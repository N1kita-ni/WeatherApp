//
//  ForecastTableViewCell.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/21/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class ForecastTableViewCell: UITableViewCell {

   static let reuseIdentifier = "forecastCell"
    
    let temperatureLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = .systemFont(ofSize: 30, weight: .bold)
        tempLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tempLabel.textAlignment = .center
        return tempLabel
    }()
    
    let timeLabel: UILabel = {
       let time = UILabel()
        time.font = .systemFont(ofSize: 15)
        time.textAlignment = .center
        return time
    }()
    
    let weatherLabel: UILabel = {
        let state = UILabel()
        state.font = .systemFont(ofSize: 15)
        state.textAlignment = .center
        return state
    }()
    
    let weakDay: UILabel = {
        let state = UILabel()
        state.font = .systemFont(ofSize: 15, weight: .bold)
        state.textAlignment = .center
        return state
    }()
    
    let forecastImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
       return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(temperatureLabel)
        addSubview(forecastImage)
        addSubview(timeLabel)
        addSubview(weakDay)
        addSubview(weatherLabel)
        setupConstr()
    }
    
    func setupConstr() {
        temperatureLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(3)
        }
        
        forecastImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(3)
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(100)
        }

        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(forecastImage.snp.trailing).offset(10)
            make.top.equalToSuperview().inset(20)
        }

        weatherLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(forecastImage.snp.trailing).offset(10)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
        weakDay.snp.makeConstraints { (make) in
            make.leading.equalTo(forecastImage.snp.trailing).offset(10)
            make.top.equalTo(weatherLabel.snp.bottom).offset(10)
        }
    }
    
    func configure(indexPath: Int, forecast: ForecastWeather) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "EEEE"
        
        if let date = dateFormatterGet.date(from: forecast.list[indexPath].dateTxt) {
            timeLabel.text  = dateFormatterTime.string(from: date)
        }
        
        if let date = dateFormatterGet.date(from: forecast.list[indexPath].dateTxt ) {
            weakDay.text = dateFormatterDay.string(from: date)
        }
        
        temperatureLabel.text = "\(Int(forecast.list[indexPath].main.temp))" + "°"
        forecastImage.sd_setImage(with: forecast.list[indexPath].weather[0].forecastWeatherIconURL, completed: nil)
        weatherLabel.text = "\(forecast.list[indexPath].weather[0].description)"
    }
}
