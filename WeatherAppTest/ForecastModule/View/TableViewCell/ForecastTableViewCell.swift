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

  // static let reuseIdentifier = "forecastCell"
    
   private lazy var temperatureLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = .systemFont(ofSize: 30, weight: .bold)
        tempLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tempLabel.textAlignment = .center
        return tempLabel
    }()
    
    private lazy var timeLabel: UILabel = {
       let time = UILabel()
        time.font = .systemFont(ofSize: 15)
        time.textAlignment = .center
        return time
    }()
    
    private lazy var weatherLabel: UILabel = {
        let state = UILabel()
        state.font = .systemFont(ofSize: 15)
        state.textAlignment = .center
        return state
    }()
    
    private lazy var forecastImage: UIImageView = {
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
    
   private func setupViews() {
        addSubviews([temperatureLabel,
                     forecastImage,
                     timeLabel,
                     weatherLabel])
        setupConstr()
    }
    
   private func setupConstr() {
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
    }
    
    func configure(forecast: ForecastData) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "EEEE"
        
        if let date = dateFormatterGet.date(from: forecast.dateTxt) {
            timeLabel.text  = dateFormatterTime.string(from: date)
        }
        
        temperatureLabel.text = "\(Int(forecast.main.temp))" + "°"
        forecastImage.sd_setImage(with: forecast.weather[0].forecastWeatherIconURL, completed: nil)
        weatherLabel.text = "\(forecast.weather[0].description)"
    }
}
