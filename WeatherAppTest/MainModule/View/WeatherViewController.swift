//
//  ViewController.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage


final class WeatherViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let gradientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var colors: [UIColor] = [#colorLiteral(red: 0.9098039269, green: 0.5254884555, blue: 0.5817584947, alpha: 1), #colorLiteral(red: 1, green: 0.9975345455, blue: 0.6872003919, alpha: 1), #colorLiteral(red: 0.5961294384, green: 0.7331562011, blue: 1, alpha: 1), #colorLiteral(red: 0.6930560762, green: 1, blue: 0.6908935261, alpha: 1), #colorLiteral(red: 0.9824787424, green: 0.7485847892, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8281603211, blue: 0.7240381341, alpha: 1)]
    
    let mainSpinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.color = .black
        spiner.style = .large
        return spiner
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = " "
        label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let pictrureFirstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    let humidityImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "humidity")
        imageView.isHidden = true
        return imageView
    }()
    
    let waterDropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "water_drop")
        imageView.isHidden = true
        return imageView
    }()
    
    let pressureImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pressure")
        imageView.isHidden = true
        return imageView
    }()
    
    
    let dataFirstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let waterDropLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let pictureSecondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    let windSpeedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "windSpeed")
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let compassImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "compass")
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let dataSecondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let compassLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(share), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        navigationItem.title = "Today"
        countryLabel.textAlignment = .center
        mainSpinner.startAnimating()
        mainSpinner.isHidden = false
        
        internetConnection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                mainSpinner.color = .white
            } else {
                mainSpinner.color = .black
            }
        }
    }
    
    private func internetConnection() {
        if NetworkConnect.shared.isConnected {
            print("Connect success")
        } else {
            let alert = UIAlertController(title: "Connect failed",
                                          message: "Check your internet connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func share() {
        let shareInfo = "Current temperature: \(Int(presenter.currentWeather?.main.temp ?? 0))" + "°C" +
            "\nCity: \(presenter.currentWeather?.name ?? "No info")" +
            "\nHumidity: \(presenter.currentWeather?.main.humidity ?? 0)" + "%" +
            "\nWind speed: \(Int(presenter.currentWeather?.wind.speed ?? 0)) " + "km/h" +
            "\nPressure: \(presenter.currentWeather?.main.pressure ?? 0) " + "hPa"
        let activityVC = UIActivityViewController(activityItems: [shareInfo], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view
        present(activityVC, animated: true, completion: nil)
    }
    
    private func hideElements() {
        humidityImage.isHidden = false
        waterDropImage.isHidden = false
        pressureImage.isHidden = false
        windSpeedImage.isHidden = false
        compassImage.isHidden = false
        shareButton.isHidden = false
        mainSpinner.isHidden = true
        mainSpinner.stopAnimating()
    }
    
    private func setupViews() {
        //view.addSubview(weatherImage)
        // view.addSubview(countryLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(gradientStackView)
        view.addSubview(shareButton)
        view.addSubview(mainSpinner)
        
        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            view.alpha = 0.8
            gradientStackView.addArrangedSubview(view)
        }
        gradientStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(5)
        }
        
        view.addSubview(pictrureFirstStackView)
        pictrureFirstStackView.addArrangedSubview(humidityImage)
        pictrureFirstStackView.addArrangedSubview(waterDropImage)
        pictrureFirstStackView.addArrangedSubview(pressureImage)
        
        view.addSubview(dataFirstStackView)
        dataFirstStackView.addArrangedSubview(humidityLabel)
        dataFirstStackView.addArrangedSubview(waterDropLabel)
        dataFirstStackView.addArrangedSubview(pressureLabel)
        
        view.addSubview(pictureSecondStackView)
        pictureSecondStackView.addArrangedSubview(windSpeedImage)
        pictureSecondStackView.addArrangedSubview(compassImage)
        
        view.addSubview(dataSecondStackView)
        dataSecondStackView.addArrangedSubview(windSpeedLabel)
        dataSecondStackView.addArrangedSubview(compassLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainSpinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(132)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(150)
            make.top.equalTo(gradientStackView.snp.bottom).offset(20)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
        temperatureLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(countryLabel.snp.bottom).offset(8.5)
        }
        
        pictrureFirstStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(21.5)
        }
        
        dataFirstStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(pictrureFirstStackView.snp.bottom).offset(5)
        }
        
        pictureSecondStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(dataFirstStackView.snp.bottom).offset(8)
        }
        
        dataSecondStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(pictureSecondStackView.snp.bottom).offset(8)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(dataSecondStackView.snp.bottom).offset(35)
        }
    }
}

extension WeatherViewController: MainViewProtocol {
    func success() {
        hideElements()
        
        let worldSide = presenter.currentWeather?.wind.deg ?? 0
        let compassValue = Compass(degree: worldSide)
        compassLabel.text = compassValue.rawValue
        
        temperatureLabel.text = "\(Int(presenter.currentWeather?.main.temp ?? 1)) °C | " + "\(presenter.currentWeather?.weather[0].main ?? "No info")"
        imageView.sd_setImage(with: presenter.currentWeather?.weather[0].weatherIconURL, completed: nil)
        countryLabel.text = "\(presenter.currentWeather?.name ?? "No info"), " + "\(presenter.currentWeather?.sys.country ?? "No info")"
        pressureLabel.text = "\(presenter.currentWeather?.main.pressure ?? 0) " + "hPa"
        windSpeedLabel.text = "\(presenter.currentWeather?.wind.speed ?? 0) " + "km/h"
        humidityLabel.text = "\(presenter.currentWeather?.main.humidity ?? 0)" + "%"
        waterDropLabel.text = "735 mm" // Не нашел в Api информацию об осадках
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
