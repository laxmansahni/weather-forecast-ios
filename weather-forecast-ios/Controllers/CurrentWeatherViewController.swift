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

class CurrentWeatherViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    
    // MARK: - Properties
    private let currentWeatherViewModel = CurrentWeatherViewModel()
    let connectionManager = ConnectionManager.shared
    var disposeBag = DisposeBag()
    
    func delay(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    
    func setupViewWithRx() {
        
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
                case .showWeather(let currentWeather):
                    self?.showDetailsView(currentWeather: currentWeather)
                }
            }).disposed(by: disposeBag)
    }
    
    private func showDetailsView(currentWeather: CurrentWeather) {
        locationLabel.text = "\(currentWeather.location.name), \(currentWeather.location.region), \(currentWeather.location.country)"
        temperatureLabel.text = "\(currentWeather.current.tempC)°C"
        conditionLabel.text = "\(currentWeather.current.condition.text)"
        conditionIcon.sd_setImage(with: URL(string: "https:\(currentWeather.current.condition.icon)"), placeholderImage: UIImage(#imageLiteral(resourceName: "partly_cloudy")))
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
    }
    
    private func hideWeatherView() {
        locationLabel.isHidden = true
        temperatureLabel.isHidden = true
        conditionLabel.isHidden = true
        conditionIcon.isHidden = true
    }
    
    private func showErrorAlert(error: Error){
        let dialogMessage = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in }))
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
