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
    
    let forecastSpinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.color = .black
        spiner.style = .large
        return spiner
    }()
    
    var colors: [UIColor] = [#colorLiteral(red: 0.9098039269, green: 0.5254884555, blue: 0.5817584947, alpha: 1), #colorLiteral(red: 1, green: 0.9975345455, blue: 0.6872003919, alpha: 1), #colorLiteral(red: 0.5961294384, green: 0.7331562011, blue: 1, alpha: 1), #colorLiteral(red: 0.6930560762, green: 1, blue: 0.6908935261, alpha: 1), #colorLiteral(red: 0.9824787424, green: 0.7485847892, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8281603211, blue: 0.7240381341, alpha: 1)]
  //  var colors: [UIColor] = [.red, .yellow, .blue, .green, .systemPink, .orange]
    
    var presenter: ForecastViewPresenterProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastTableView.dataSource = self
        forecastTableView.delegate = self
        forecastSpinner.startAnimating()
        forecastSpinner.isHidden = false
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        success()
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           if #available(iOS 12.0, *) {
               if traitCollection.userInterfaceStyle == .dark {
                   forecastSpinner.color = .white
               } else {
                   forecastSpinner.color = .black
               }
           }
       }
    
    private func setupViews() {
        view.addSubview(forecastTableView)
        view.addSubview(gradientStackView)
        forecastTableView.addSubview(forecastSpinner)
        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            view.alpha = 0.8
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
        
        forecastSpinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

extension ForecastViewController: ForecastViewProtocol {
    func success() {
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationItem.title = "\(self.presenter.forecastWeather?.city.name ?? "Forecast")"
            self.forecastTableView.reloadData()
        }
   // }
        
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - TableViewDataSource, TableViewDelegate
extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.forecastWeather?.list.count ?? 0
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 6
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier, for: indexPath) as? ForecastTableViewCell
        let forecast = presenter.forecastWeather?.list[indexPath.row]
       let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        
        let dateFormatterDay = DateFormatter()
        dateFormatterDay.dateFormat = "EEEE"
        
        if let date = dateFormatterGet.date(from: forecast?.dateTxt ?? "0") {
            cell?.timeLabel.text  = dateFormatterTime.string(from: date)
        }

        if let date = dateFormatterGet.date(from: forecast?.dateTxt ?? "0") {
            cell?.weakDay.text = dateFormatterDay.string(from: date)
        }
        
        cell?.temperatureLabel.text = "\(Int(forecast?.main.temp ?? 0) )" + "°"
        cell?.forecastImage.sd_setImage(with: forecast?.weather[0].forecastWeatherIconURL, completed: nil)
        cell?.weatherLabel.text = "\(forecast?.weather[0].description ?? "No info")"
        self.forecastSpinner.stopAnimating()
        self.forecastSpinner.isHidden = true

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier) as? ForecastTableViewCell
//
//    }
    // MARK: - TableViewDelegate
//    extension ForecastViewController: UITableViewDelegate {
//
////    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
////        let dateFormatterGet = DateFormatter()
////        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
////
////        let dateFormatter = DateFormatter()
////        dateFormatter.dateFormat = "EEEE"
////        guard let date = dateFormatterGet.date(from: presenter.forecastWeather?.list[0].dateTxt ?? "0") else { return ""}
////
////           return dateFormatter.string(from: date)
////    }
////
//
//}
