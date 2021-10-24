//
//  ForecastViewController.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class ForecastViewController: UIViewController {
    
    let forecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    let gradientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var colors: [UIColor] = [.red, .yellow, .blue, .green, .systemPink, .orange]
    
    var presenter: ForecastViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
        //success()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        success()
    }
    
    private func setupViews() {
        view.addSubview(forecastTableView)
        view.addSubview(gradientStackView)
        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            gradientStackView.addArrangedSubview(view)
        }
        setupConstraint()
        
    }
    
    private func setupConstraint() {
        forecastTableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(gradientStackView.snp.bottom).offset(0)
        }
        
        gradientStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(5)
        }
    }
}

extension ForecastViewController: ForecastViewProtocol {
    func success() {
        title = "\(presenter.forecastWeather?.city.name ?? "nil")"
        forecastTableView.reloadData()
    }
        
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.forecastWeather?.list.count ?? 0
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {

//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier, for: indexPath) as? ForecastTableViewCell
        let forecast = presenter.forecastWeather?.list[indexPath.row]
       let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

//        print(presenter.forecastWeather?.list.count)
        cell?.temperatureLabel.text = "\(Int(forecast?.main.temp ?? 0) )" + "°"
        cell?.forecastImage.sd_setImage(with: forecast?.weather[0].forecastWeatherIconURL, completed: nil)
        
        if let date = dateFormatterGet.date(from: forecast?.dateTxt ?? "0") {
           cell?.timeLabel.text  = dateFormatter.string(from: date)
        }
        cell?.weatherLabel.text = "\(forecast?.weather[0].description ?? "No info")"
        //cell?.timeLabel.text = "\(dateFormatter.date(from: forecast?.dateTxt ?? "o") ?? Date())"
      //  cell?.textLabel?.text = "\(presenter.forecastWeather?.list[0].main.temp ?? 0)"
        return cell ?? UITableViewCell()
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier) as? ForecastTableViewCell
//
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        guard let date = dateFormatterGet.date(from: presenter.forecastWeather?.list[0].dateTxt ?? "0") else { return ""}
        
           return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
