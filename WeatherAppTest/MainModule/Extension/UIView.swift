////
////  UIView.swift
////  WeatherAppTest
////
////  Created by Никита Ничепорук on 10/19/21.
////  Copyright © 2021 Никита Ничепорук. All rights reserved.
////
//
//import UIKit
//import SnapKit
//
//extension WeatherViewController {
//
//     let gradientStackView: UIStackView = {
//            let stackView = UIStackView()
//            stackView.frame = CGRect(x: 0, y: 88, width: 414, height: 5)
//            stackView.axis = .horizontal
//            stackView.distribution = .fillEqually
//           // stackView.translatesAutoresizingMaskIntoConstraints = false
//            return stackView
//        }()
//
//        let redView: UIView = {
//            let red = UIView()
//            red.contentMode = .scaleToFill
//            red.backgroundColor = .red
//            red.frame.size = CGSize(width: 69, height: 5)
//           return red
//        }()
//
//        let yellowView: UIView = {
//               let red = UIView()
//               red.contentMode = .scaleToFill
//               red.backgroundColor = .yellow
//               red.frame.size = CGSize(width: 69, height: 5)
//              return red
//           }()
//
//        let blueView: UIView = {
//               let red = UIView()
//               red.contentMode = .scaleToFill
//               red.backgroundColor = .blue
//               red.frame.size = CGSize(width: 69, height: 5)
//              return red
//           }()
//
//        let greenView: UIView = {
//               let red = UIView()
//               red.contentMode = .scaleToFill
//               red.backgroundColor = .green
//               red.frame.size = CGSize(width: 69, height: 5)
//              return red
//           }()
//
//        let pinkView: UIView = {
//               let red = UIView()
//               red.contentMode = .scaleToFill
//               red.backgroundColor = .systemPink
//               red.frame.size = CGSize(width: 69, height: 5)
//              return red
//           }()
//
//        let orangeView: UIView = {
//               let red = UIView()
//               red.contentMode = .scaleToFill
//               red.backgroundColor = .orange
//               red.frame.size = CGSize(width: 69, height: 5)
//              return red
//           }()
//        let weatherImage: UIImageView = {
//           let imageView = UIImageView()
//            imageView.image = UIImage(named: "sungl")
//            imageView.frame = CGRect(x: 132, y: 190, width: 150, height: 150)
//           // imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//
//        let countryLabel: UILabel = {
//            let label = UILabel()
//            label.frame = CGRect(x: 10, y: 360, width: 394, height: 21)
//            label.font = UIFont(name: "San Francisco", size: 17)
//            label.text = "Belarus, Minsk"
//            label.textAlignment = .center
//            return label
//        }()
//
//        let temperatureLabel: UILabel = {
//               let label = UILabel()
//               label.frame = CGRect(x: 10, y: 389, width: 394, height: 27)
//               label.font = UIFont(name: "San Francisco", size: 25)
//               label.text = "18°"
//               label.textColor = .blue
//               label.textAlignment = .center
//               return label
//           }()
//
//        let pictrureFirstStackView: UIStackView = {
//            let stackView = UIStackView()
//            stackView.frame = CGRect(x: 30, y: 437, width: 354, height: 24)
//            stackView.axis = .horizontal
//            stackView.distribution = .equalSpacing
//           // stackView.translatesAutoresizingMaskIntoConstraints = false
//            return stackView
//        }()
//
//
//        let humidityImage: UIImageView = {
//           let imageView = UIImageView()
//            imageView.image = UIImage(named: "humidity")
//            imageView.frame.size = CGSize(width: 24, height: 24)
//           // imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//
//        let waterDropImage: UIImageView = {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: "water_drop")
//            imageView.frame.size = CGSize(width: 24, height: 24)
//            // imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//
//        let pressureImage: UIImageView = {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: "pressure")
//            imageView.frame.size = CGSize(width: 24, height: 24)
//            // imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//
//        let dataFirstStackView: UIStackView = {
//            let stackView = UIStackView()
//            stackView.frame = CGRect(x: 30, y: 466, width: 379, height: 17)
//            stackView.axis = .horizontal
//            stackView.distribution = .equalSpacing
//            // stackView.translatesAutoresizingMaskIntoConstraints = false
//            return stackView
//        }()
//
//        let humidityLabel: UILabel = {
//            let label = UILabel()
//            label.frame.size = CGSize(width: 28, height: 17)
//            label.font = UIFont(name: "San Francisco", size: 14)
//            label.text = "57%"
//            label.textAlignment = .center
//            return label
//        }()
//
//        let waterDropLabel: UILabel = {
//            let label = UILabel()
//            label.frame.size = CGSize(width: 46.5, height: 17)
//            label.font = UIFont(name: "San Francisco", size: 14)
//            label.text = "1.0 mm"
//            label.textAlignment = .center
//            return label
//        }()
//
//        let pressureLabel: UILabel = {
//            let label = UILabel()
//            label.frame.size = CGSize(width: 58.5, height: 17)
//            label.font = UIFont(name: "San Francisco", size: 14)
//            label.text = "1000 hPa"
//            label.textAlignment = .center
//            return label
//        }()
//
//        let pictureSecondStackView: UIStackView = {
//               let stackView = UIStackView()
//               stackView.frame = CGRect(x: 30, y: 491, width: 354, height: 24)
//               stackView.axis = .horizontal
//               stackView.distribution = .fillProportionally
//               // stackView.translatesAutoresizingMaskIntoConstraints = false
//               return stackView
//           }()
//
//        let windSpeedImage: UIImageView = {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: "windSpeed")
//            imageView.contentMode = .scaleAspectFit
//            imageView.frame.size = CGSize(width: 177, height: 24)
//            // imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//
//        let compassImage: UIImageView = {
//            let imageView = UIImageView()
//            imageView.image = UIImage(named: "compass")
//            imageView.contentMode = .scaleAspectFit
//            imageView.frame.size = CGSize(width: 177, height: 24)
//            // imageView.translatesAutoresizingMaskIntoConstraints = false
//            return imageView
//        }()
//
//        let dataSecondStackView: UIStackView = {
//            let stackView = UIStackView()
//            stackView.frame = CGRect(x: 95, y: 523, width: 254, height: 17)
//            stackView.axis = .horizontal
//            stackView.distribution = .fillProportionally
//            // stackView.translatesAutoresizingMaskIntoConstraints = false
//            return stackView
//        }()
//
//        let windSpeedLabel: UILabel = {
//            let label = UILabel()
//            label.frame.size = CGSize(width: 192.5, height: 17)
//            label.font = UIFont(name: "San Francisco", size: 14)
//            label.text = "20 km/h"
//            label.textAlignment = .left
//            return label
//        }()
//
//        let compassLabel: UILabel = {
//            let label = UILabel()
//            label.frame.size = CGSize(width: 61.5, height: 17)
//            label.font = UIFont(name: "San Francisco", size: 14)
//            label.text = "SE"
//            label.textAlignment = .left
//            return label
//        }()
//
//        let shareButton: UIButton = {
//            let button = UIButton(type: .system)
//            button.frame = CGRect(x: 10, y: 575, width: 394, height: 36)
//            button.titleLabel?.text = "Share"
//            button.addTarget(self, action: #selector(share), for: .touchUpInside)
//           return button
//        }()
//
//        @objc func share() {
//
//        }
//    //    convenience init() {
//    //        self.init(nibName: "WeatherViewController", bundle: nil)
//    //    }
//
//        func setupViews() {
//            view.addSubview(weatherImage)
//            view.addSubview(countryLabel)
//            view.addSubview(temperatureLabel)
//            view.addSubview(shareButton)
//
//            view.addSubview(gradientStackView)
//            gradientStackView.addArrangedSubview(redView)
//            gradientStackView.addArrangedSubview(yellowView)
//            gradientStackView.addArrangedSubview(blueView)
//            gradientStackView.addArrangedSubview(greenView)
//            gradientStackView.addArrangedSubview(pinkView)
//            gradientStackView.addArrangedSubview(orangeView)
//
//            view.addSubview(pictrureFirstStackView)
//            pictrureFirstStackView.addArrangedSubview(humidityImage)
//            pictrureFirstStackView.addArrangedSubview(waterDropImage)
//            pictrureFirstStackView.addArrangedSubview(pressureImage)
//
//            view.addSubview(dataFirstStackView)
//            dataFirstStackView.addArrangedSubview(humidityLabel)
//            dataFirstStackView.addArrangedSubview(waterDropLabel)
//            dataFirstStackView.addArrangedSubview(pressureLabel)
//
//            view.addSubview(pictureSecondStackView)
//            pictureSecondStackView.addArrangedSubview(windSpeedImage)
//            pictureSecondStackView.addArrangedSubview(compassImage)
//
//            view.addSubview(dataSecondStackView)
//            dataSecondStackView.addArrangedSubview(windSpeedLabel)
//            dataSecondStackView.addArrangedSubview(compassLabel)
//        }
//
//        func setupConstraints() {
//            gradientStackView.snp.makeConstraints { (make) in
//                make.leading.trailing.top.equalToSuperview()
//                make.bottom.equalTo(weatherImage.snp.top).offset(97)
//            }
//
//            weatherImage.snp.makeConstraints { (make) in
//                make.leading.equalTo(132)
//                make.trailing.equalTo(132)
//                make.width.equalTo(150)
//                make.height.equalTo(150)
//                make.top.equalTo(102)
//                make.top.equalTo(gradientStackView.snp.bottom).offset(97)
//                make.bottom.equalTo(countryLabel.snp.top).offset(20)
//            }
//
//            countryLabel.snp.makeConstraints { (make) in
//                make.leading.trailing.equalToSuperview().offset(10)
//                make.top.equalTo(weatherImage.snp.bottom).offset(20)
//                make.bottom.equalTo(temperatureLabel.snp.top).offset(8.5)
//            }
//
//            temperatureLabel.snp.makeConstraints { (make) in
//                make.leading.trailing.equalToSuperview().offset(10)
//                make.top.equalTo(countryLabel.snp.bottom).offset(8.5)
//                make.bottom.equalTo(pictrureFirstStackView.snp.top).offset(21.5)
//            }
//
//            pictrureFirstStackView.snp.makeConstraints { (make) in
//                make.leading.trailing.equalToSuperview().offset(30)
//                make.top.equalTo(temperatureLabel.snp.bottom).offset(21.5)
//                make.bottom.equalToSuperview().priority(.low)
//                make.bottom.equalTo(dataFirstStackView.snp.top).offset(5)
//            }
//
//            dataFirstStackView.snp.makeConstraints { (make) in
//                make.leading.equalTo(30)
//                make.trailing.equalTo(5)
//                make.top.equalTo(pictrureFirstStackView.snp.bottom).offset(5)
//                make.bottom.equalToSuperview().priority(.low)
//                make.bottom.equalTo(pictureSecondStackView.snp.top).offset(8)
//
//            }
//
//            pictureSecondStackView.snp.makeConstraints { (make) in
//                make.leading.trailing.equalToSuperview().offset(30)
//                make.top.equalTo(dataFirstStackView.snp.bottom).offset(8)
//                make.bottom.equalToSuperview().priority(.low)
//                make.bottom.equalTo(dataSecondStackView.snp.top).offset(8)
//            }
//
//            dataSecondStackView.snp.makeConstraints { (make) in
//                make.leading.equalTo(95)
//                make.trailing.equalTo(65)
//                make.bottom.equalToSuperview().priority(.low)
//                make.top.equalTo(pictureSecondStackView.snp.bottom).offset(8)
//                make.bottom.equalTo(shareButton.snp.top).offset(35)
//            }
//
//            shareButton.snp.makeConstraints { (make) in
//                make.leading.trailing.equalToSuperview().offset(10)
//                make.top.equalTo(dataSecondStackView.snp.bottom).offset(35)
//
//            }
//        }
//    }
//
//
//
