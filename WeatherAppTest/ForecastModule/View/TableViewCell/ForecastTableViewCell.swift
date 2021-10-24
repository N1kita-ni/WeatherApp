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
    var presener: ForecastViewPresenterProtocol!
    
    let temperatureLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = .systemFont(ofSize: 30, weight: .bold)
        tempLabel.text = " lkwefj"
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
        addSubview(weatherLabel)
        setupConstr()
    }
    
    func setupConstr() {
        temperatureLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(3)
            //make.leading.equalToSuperview().inset(50)
            
        }
        
        forecastImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(3)
            make.top.bottom.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(forecastImage.snp.trailing).offset(10)
            //make.trailing.equalTo(temperatureLabel.snp.leading).offset(100)
            make.top.equalToSuperview().inset(20)
        }
        
        weatherLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(forecastImage.snp.trailing).offset(10)
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
        }
    }
    
    func configure(indexPath: Int) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        temperatureLabel.text = "\(Int(presener.forecastWeather?.list[indexPath].main.temp ?? 0))"
        forecastImage.sd_setImage(with: presener.forecastWeather?.list[indexPath].weather[0].forecastWeatherIconURL, completed: nil)
        timeLabel.text = "\(dateFormatter.date(from: presener.forecastWeather?.list[indexPath].dateTxt ?? "0" ) ?? Date())"
    }
}
