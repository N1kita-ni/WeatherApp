//
//  ForecastViewController.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit
import SnapKit

class ForecastViewController: UIViewController {
    
    private lazy var forecastTableView: UITableView = {
        let tableView = UITableView()
        //tableView.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.reuseIdentifier)
        tableView.register(ForecastTableViewCell.self)
        tableView.allowsSelection = false 
        return tableView
    }()
    
    private lazy var gradientStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var forecastSpinner: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        spiner.color = .black
        spiner.style = .large
        return spiner
    }()
    
    
   private let colors: [UIColor] = [#colorLiteral(red: 0.9098039269, green: 0.5254884555, blue: 0.5817584947, alpha: 1), #colorLiteral(red: 1, green: 0.9975345455, blue: 0.6872003919, alpha: 1), #colorLiteral(red: 0.5961294384, green: 0.7331562011, blue: 1, alpha: 1), #colorLiteral(red: 0.6930560762, green: 1, blue: 0.6908935261, alpha: 1), #colorLiteral(red: 0.9824787424, green: 0.7485847892, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8281603211, blue: 0.7240381341, alpha: 1)]
    
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
        view.addSubviews([forecastTableView, gradientStackView])
        forecastTableView.addSubview(forecastSpinner)
        colors.forEach {
            let view = UIView()
            view.backgroundColor = $0
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
        navigationItem.title = (presenter.forecastWeather?.city.name ?? "Forecast")
            forecastTableView.reloadData()
        }
        
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
// MARK: - TableViewDataSource, TableViewDelegate
extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.forecastSections[section].data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter.forecastSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseIdentifier, for: indexPath) as? ForecastTableViewCell else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(ForecastTableViewCell.self, for: indexPath)
        
        cell.configure(forecast: presenter.forecastSections[indexPath.section].data[indexPath.row])
        
        self.forecastSpinner.stopAnimating()
        self.forecastSpinner.isHidden = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray3
        let label = UILabel()
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.trailing.bottom.top.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        label.textColor = .white
        label.font = .systemFont(ofSize: 20)
        label.text = presenter.forecastSections[section].header
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
