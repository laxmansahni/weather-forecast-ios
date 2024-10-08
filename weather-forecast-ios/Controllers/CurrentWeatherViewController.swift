//
//  CurrentWeatherViewController.swift
//  weather-forecast-ios
//
//  Created by Laxman on 16/09/24.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SwiftLoader
import FittedSheets

class CurrentWeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    @IBOutlet weak var forecastWeatherButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let currentWeatherViewModel = CurrentWeatherViewModel()
    let connectionManager = ConnectionManager.shared
    var disposeBag = DisposeBag()
    
    func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        configureShowLoader()
        setupViewWithRx()
        /// Usage of ConnectionManager class
        if connectionManager.isConnected {
            self.currentWeatherViewModel.isConnected = true
        } else {
            self.currentWeatherViewModel.isConnected = false
        }
        currentWeatherViewModel.getWeatherData()
    }
    
    // MARK: - Methods
    private func setupTableView() {
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
       
    }
    
    private func setupViewWithRx() {
        
        currentWeatherViewModel.uiActions
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
                case .reloadCities:
                    strongSelf.hideWeatherView()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .showWeather(let currentWeather):
                    self?.showDetailsView(currentWeather: currentWeather)
                case .showDetailsWeather(let city):
                    self?.showDetailsSheetView(city: city)
                }
            }).disposed(by: disposeBag)
        
        // List of forecast days
        currentWeatherViewModel.cityRowItems
            .bind(to: tableView.rx.items) { (tableView, index, rowViewModel) -> UITableViewCell in
                guard let cellIdentifier = rowViewModel.cellIdentifier,
                      cellIdentifier.count > 0,
                      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? BaseTableViewCell else { return UITableViewCell() }
                cell.setupCell(rowViewModel: rowViewModel)
                return cell
            }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind {[weak self] (indexPath) in
            self?.currentWeatherViewModel.handleCityTableSelection(indexPath)
        }.disposed(by: disposeBag)
    }
    
    private func showDetailsView(currentWeather: CurrentWeather) {
        locationLabel.text = "\(currentWeather.location.name), \(currentWeather.location.region), \(currentWeather.location.country)"
        temperatureLabel.text = "\(currentWeather.current.tempC)°C"
        conditionLabel.text = "\(currentWeather.current.condition.text)"
        conditionIcon.sd_setImage(with: URL(string: "https:\(currentWeather.current.condition.icon)"), placeholderImage: UIImage(#imageLiteral(resourceName: "partly_cloudy")))
    }
    
    private func showDetailsSheetView(city: SearchCity) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController else { return }
        controller.weatherDetailsViewModel = WeatherDetailsViewModel(city: city)
        let sheetController = SheetViewController(
            controller: controller,
            sizes: [.percent(0.53)],
            options: SheetOptions(
                pullBarHeight: 0,
                shouldExtendBackground: true,
                useFullScreenMode: true,
                shrinkPresentingViewController: false))
        sheetController.dismissOnPull = false
        sheetController.dismissOnOverlayTap = true
        sheetController.allowPullingPastMaxHeight = false
        sheetController.allowPullingPastMinHeight = false
        self.present(sheetController, animated: true, completion: nil)
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
        temperatureLabel.isHidden = false
        conditionLabel.isHidden = false
        conditionIcon.isHidden = false
        forecastWeatherButton.isHidden = false
        tableView.isHidden = true
    }
    
    private func hideWeatherView() {
        locationLabel.isHidden = true
        temperatureLabel.isHidden = true
        conditionLabel.isHidden = true
        conditionIcon.isHidden = true
        forecastWeatherButton.isHidden = true
        tableView.isHidden = false
    }
    
    private func showErrorAlert(error: Error){
        let dialogMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in }))
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func forecastWeatherButtonClicked(_ sender: Any) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "ForecastDaysViewController") as? ForecastDaysViewController else { return }
        self.navigationController?.pushViewController(controller, animated: true)
    }

    @IBAction func searchButtonClicked(_ sender: Any) {
        
        guard let search = searchTextField.text, search != "" else {
            return
        }
        currentWeatherViewModel.searchCityData(city: search)
    }
}

// MARK: - UITextFieldDelegate
extension CurrentWeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
