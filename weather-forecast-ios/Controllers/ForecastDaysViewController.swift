//
//  ForecastDaysViewController.swift
//  weather-forecast-ios
//
//  Created by Laxman on 17/09/24.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SwiftLoader

class ForecastDaysViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let forecastDaysViewModel = ForecastDaysViewModel()
    let connectionManager = ConnectionManager.shared
    var disposeBag = DisposeBag()
    
    func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Forecast Days"
        setupTableView()
        configureShowLoader()
        setupViewWithRx()
        /// Usage of ConnectionManager class
        if connectionManager.isConnected {
            self.forecastDaysViewModel.isConnected = true
        } else {
            self.forecastDaysViewModel.isConnected = false
        }
        forecastDaysViewModel.getWeatherData()
    }
    
    // MARK: - Methods
    private func setupTableView() {
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil), forCellReuseIdentifier: ForecastTableViewCell.identifier)
        tableView.rowHeight = 195
        tableView.estimatedRowHeight = 195
       
    }
    
    private func setupViewWithRx() {
        
        forecastDaysViewModel.uiActions
            .bind(onNext: { [weak self] uiAction in
                
                guard let strongSelf = self else { return }
                
                switch uiAction {
                case .showLoading:
                    strongSelf.hideWeatherView()
                    strongSelf.delay(seconds: 0.0) { () -> () in
                        SwiftLoader.show(title: "Loading...", animated: true)
                        
                    }
                    break
                case .hideLoading:
                    strongSelf.showWeatherView()
                    strongSelf.delay(seconds: 0.0) { () -> () in
                        SwiftLoader.hide()
                    }
                    
                    break
                case .showError(let error):
                    strongSelf.showErrorAlert(error: error)
                    break
                case .reloadForecast:
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .showWeather(let currentWeather):
                    self?.showDetailsView(currentWeather: currentWeather)
                }
            }).disposed(by: disposeBag)
        
        // List of forecast days
        forecastDaysViewModel.forecastRowItems
            .bind(to: tableView.rx.items) { (tableView, index, rowViewModel) -> UITableViewCell in
                guard let cellIdentifier = rowViewModel.cellIdentifier,
                      cellIdentifier.count > 0,
                      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? BaseTableViewCell else { return UITableViewCell() }
                cell.setupCell(rowViewModel: rowViewModel)
                return cell
            }.disposed(by: disposeBag)
    }
    
    private func showDetailsView(currentWeather: ForecastDays) {
        locationLabel.text = "\(currentWeather.location.name), \(currentWeather.location.region), \(currentWeather.location.country)"
    }
    
    private func configureShowLoader() {
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 150
        config.spinnerColor = .red
        config.foregroundColor = .black
        config.foregroundAlpha = 0.5
        
        SwiftLoader.setConfig(config)
        
    }
    
    private func showWeatherView() {
        locationLabel.isHidden = false
    }
    
    private func hideWeatherView() {
        locationLabel.isHidden = true
    }
    
    private func showErrorAlert(error: Error){
        let dialogMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in }))
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
