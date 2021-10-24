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
    
    @IBOutlet weak var imageView: UIImageView!
    let gradientStackView: UIStackView = {
        let stackView = UIStackView()
       // stackView.frame = CGRect(x: 0, y: 0, width: 414, height: 5)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    @IBOutlet weak var countryLabel: UILabel!
    var colors: [UIColor] = [.red, .yellow, .blue, .green, .systemPink, .orange]

//    let weatherImage: UIImageView = {
//       let imageView = UIImageView()
//        imageView.image = UIImage(named: "sungl")
//        imageView.contentMode = .scaleAspectFit
//        //imageView.frame = CGRect(x: 132, y: 190, width: 150, height: 150)
//       // imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//
//    let countryLabel: UILabel = {
//        let label = UILabel()
//        //label.frame = CGRect(x: 10, y: 360, width: 394, height: 21)
//        label.font = UIFont(name: "San Francisco", size: 17)
//        label.text = " "
//        label.textAlignment = .center
//        return label
//    }()
//
    let mainSpinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.color = .black
        spiner.style = .large
        return spiner
    }()
    
    let temperatureLabel: UILabel = {
           let label = UILabel()
           //label.frame = CGRect(x: 10, y: 389, width: 394, height: 27)
           label.font = .systemFont(ofSize: 20, weight: .bold)
           label.text = " "
           label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
           label.textAlignment = .center
           return label
       }()
    
    let pictrureFirstStackView: UIStackView = {
        let stackView = UIStackView()
        //stackView.frame = CGRect(x: 30, y: 437, width: 354, height: 24)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()


    let humidityImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "humidity")
        //imageView.frame.size = CGSize(width: 24, height: 24)
        return imageView
    }()

    let waterDropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "water_drop")
       // imageView.frame.size = CGSize(width: 24, height: 24)
        return imageView
    }()

    let pressureImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pressure")
        //imageView.frame.size = CGSize(width: 24, height: 24)
        return imageView
    }()


    let dataFirstStackView: UIStackView = {
        let stackView = UIStackView()
       // stackView.frame = CGRect(x: 30, y: 466, width: 379, height: 17)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    let humidityLabel: UILabel = {
        let label = UILabel()
       // label.frame.size = CGSize(width: 28, height: 17)
        label.font = UIFont(name: "San Francisco", size: 14)
        label.text = "57%"
        label.textAlignment = .center
        return label
    }()

    let waterDropLabel: UILabel = {
        let label = UILabel()
      //  label.frame.size = CGSize(width: 46.5, height: 17)
        label.font = UIFont(name: "San Francisco", size: 14)
        label.text = "1.0 mm"
        label.textAlignment = .center
        return label
    }()

    let pressureLabel: UILabel = {
        let label = UILabel()
       // label.frame.size = CGSize(width: 58.5, height: 17)
        label.font = UIFont(name: "San Francisco", size: 14)
        label.text = "1000 hPa"
        label.textAlignment = .center
        return label
    }()
//
    let pictureSecondStackView: UIStackView = {
           let stackView = UIStackView()
           //stackView.frame = CGRect(x: 30, y: 491, width: 354, height: 24)
           stackView.axis = .horizontal
           stackView.distribution = .fillProportionally
           return stackView
       }()

    let windSpeedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "windSpeed")
        imageView.contentMode = .scaleAspectFit
        //imageView.frame.size = CGSize(width: 177, height: 24)
        return imageView
    }()

    let compassImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "compass")
        imageView.contentMode = .scaleAspectFit
        //imageView.frame.size = CGSize(width: 177, height: 24)
        return imageView
    }()
//
    let dataSecondStackView: UIStackView = {
        let stackView = UIStackView()
      //  stackView.frame = CGRect(x: 95, y: 523, width: 254, height: 17)
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()

    let windSpeedLabel: UILabel = {
        let label = UILabel()
      //  label.frame.size = CGSize(width: 192.5, height: 17)
        label.font = UIFont(name: "San Francisco", size: 14)
        label.text = "20 km/h"
        label.textAlignment = .left
        return label
    }()

    let compassLabel: UILabel = {
        let label = UILabel()
       // label.frame.size = CGSize(width: 61.5, height: 17)
        label.font = UIFont(name: "San Francisco", size: 14)
        label.text = "SE"
        label.textAlignment = .left
        return label
    }()

    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        //button.frame = CGRect(x: 10, y: 575, width: 394, height: 36)
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(share), for: .touchUpInside)
       return button
    }()

    var presenter: MainViewPresenterProtocol!
    
    override func viewDidLoad() {
       // let forecast = UIBarButtonItem(image: UIImage(systemName: "thermometer"), style: .plain, target: self, action: #selector(action))
        super.viewDidLoad()
        setupViews()
        title = "Today"
       // navigationItem.rightBarButtonItem = forecast
        countryLabel.textAlignment = .center
        mainSpinner.startAnimating()
        mainSpinner.isHidden = false
        
        presenter.internerConnection()
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
//    convenience init() {
//        self.init(nibName: "WeatherViewController", bundle: nil)
//    }
    
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
//        gradientStackView.snp.makeConstraints { (make) in
//            make.leading.trailing.equalToSuperview()
//            make.top.equalToSuperview().inset(188)
//            make.height.equalTo(5)
//        }
        mainSpinner.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(132)//equalToSuperview().inset(132)
           // make.trailing.lessThanOrEqualToSuperview().inset(132)
            make.width.lessThanOrEqualToSuperview()
            make.height.equalTo(150)
           // make.top.equalTo(102)
            make.top.equalTo(gradientStackView.snp.bottom).offset(20)
            //make.bottom.equalTo(countryLabel.snp.top).offset(20)
        }
        
        countryLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            //make.bottom.equalTo(temperatureLabel.snp.top).offset(8.5)
        }
        
        temperatureLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(countryLabel.snp.bottom).offset(8.5)
           // make.bottom.equalToSuperview().inset(350)
        }
        
        pictrureFirstStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(21.5)
//            make.bottom.equalToSuperview()
//            make.bottom.equalTo(dataFirstStackView.snp.top).offset(5)
        }

        dataFirstStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(pictrureFirstStackView.snp.bottom).offset(5)
            //make.bottom.equalToSuperview()
            //make.bottom.equalTo(pictureSecondStackView.snp.top).offset(8)

        }
//
        pictureSecondStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(dataFirstStackView.snp.bottom).offset(8)
            //make.bottom.equalToSuperview()
           // make.bottom.equalTo(dataSecondStackView.snp.top).offset(8)
        }
//
        dataSecondStackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(85)
            make.trailing.equalToSuperview().inset(65)
          //  make.bottom.equalToSuperview().priority(.low)
            make.top.equalTo(pictureSecondStackView.snp.bottom).offset(8)
            //make.bottom.equalTo(shareButton.snp.top).offset(35)
        }

        shareButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(dataSecondStackView.snp.bottom).offset(35)
//
        }
    }
}

extension WeatherViewController: MainViewProtocol {
    func success() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.mainSpinner.stopAnimating()
            self.mainSpinner.isHidden = true
            self.temperatureLabel.text = "\(Int(self.presenter.currentWeather?.main.temp ?? 1)) °C | " + "\(self.presenter.currentWeather?.weather[0].main ?? "хуй")"
            self.imageView.sd_setImage(with: self.presenter.currentWeather?.weather[0].weatherIconURL, completed: nil)
            self.countryLabel.text = "\(self.presenter.currentWeather?.name ?? "Nil"), " + "\(self.presenter.currentWeather?.sys.country ?? "Nil")"
            self.pressureLabel.text = "\(self.presenter.currentWeather?.main.pressure ?? 0) " + "hPa"
            self.windSpeedLabel.text = "\(self.presenter.currentWeather?.wind.speed ?? 0) " + "km/h"
            self.compassLabel.text = "\(self.presenter.currentWeather?.wind.deg ?? 360)"
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
