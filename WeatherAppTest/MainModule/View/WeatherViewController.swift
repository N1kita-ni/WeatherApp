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

enum Compass {
    case N, NE, E, SE, S, SW, W, NW
}

final class WeatherViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var imageView: UIImageView!
    let gradientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    @IBOutlet weak var countryLabel: UILabel!
    var colors: [UIColor] = [#colorLiteral(red: 0.9098039269, green: 0.5254884555, blue: 0.5817584947, alpha: 1), #colorLiteral(red: 1, green: 0.9975345455, blue: 0.6872003919, alpha: 1), #colorLiteral(red: 0.5961294384, green: 0.7331562011, blue: 1, alpha: 1), #colorLiteral(red: 0.6930560762, green: 1, blue: 0.6908935261, alpha: 1), #colorLiteral(red: 0.9824787424, green: 0.7485847892, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8281603211, blue: 0.7240381341, alpha: 1)]
      //var colors: [UIColor] = [#colorLiteral(red: 0.9098039269, green: 0.5254884555, blue: 0.5817584947, alpha: 1), #colorLiteral(red: 1, green: 0.9975345455, blue: 0.6872003919, alpha: 1), .blue, .green, .systemPink, .orange]

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
    
    private func hiden() {
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

        pictureSecondStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(dataFirstStackView.snp.bottom).offset(8)
            //make.bottom.equalToSuperview()
           // make.bottom.equalTo(dataSecondStackView.snp.top).offset(8)
        }
        
        dataSecondStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(30)
          //  make.bottom.equalToSuperview().priority(.low)
            make.top.equalTo(pictureSecondStackView.snp.bottom).offset(8)
            //make.bottom.equalTo(shareButton.snp.top).offset(35)
        }

        shareButton.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.equalTo(dataSecondStackView.snp.bottom).offset(35)
        }
    }
}

extension WeatherViewController: MainViewProtocol {
    func success() {
        //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hiden()
        
        let worldSide = presenter.currentWeather?.wind.deg ?? 0
        switch worldSide {
        case 0:
            compassLabel.text = "\(Compass.N)"
        case 0..<90:
            compassLabel.text = "\(Compass.NE)"
        case 90:
            compassLabel.text = "\(Compass.E)"
        case 90..<180:
            compassLabel.text = "\(Compass.SE)"
        case 180:
            compassLabel.text = "\(Compass.S)"
        case 180..<270:
            compassLabel.text = "\(Compass.SW)"
        case 270:
            compassLabel.text = "\(Compass.W)"
        case 270..<360:
            compassLabel.text = "\(Compass.NW)"
        default:
            compassLabel.text = "\(Compass.N)"
        }
                    self.temperatureLabel.text = "\(Int(self.presenter.currentWeather?.main.temp ?? 1)) °C | " + "\(self.presenter.currentWeather?.weather[0].main ?? "No info")"
            self.imageView.sd_setImage(with: self.presenter.currentWeather?.weather[0].weatherIconURL, completed: nil)
            self.countryLabel.text = "\(self.presenter.currentWeather?.name ?? "No info"), " + "\(self.presenter.currentWeather?.sys.country ?? "No info")"
            self.pressureLabel.text = "\(self.presenter.currentWeather?.main.pressure ?? 0) " + "hPa"
            self.windSpeedLabel.text = "\(self.presenter.currentWeather?.wind.speed ?? 0) " + "km/h"
           // self.compassLabel.text = "\(self.presenter.currentWeather?.wind.deg ?? 360)"
            self.humidityLabel.text = "\(self.presenter.currentWeather?.main.humidity ?? 0)" + "%"
            self.waterDropLabel.text = "735 mm" // Не нашел в Api информацию об осадках
        }
   // }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
