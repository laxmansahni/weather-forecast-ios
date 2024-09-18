//
//  ForecastTableViewCell.swift
//  weather-forecast-ios
//
//  Created by Laxman on 18/09/24.
//

import UIKit

class ForecastTableViewCell: BaseTableViewCell {
    static let identifier = "ForecastTableViewCell"
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!
    
    var rowViewModel: RowViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setupCell(rowViewModel: RowViewModel) {
        guard let forecastday = rowViewModel.data as? Forecastday else { return }
        dateLabel.text = "\(forecastday.date)"
        maxTemperatureLabel.text = "\(forecastday.day.maxtempC)°C"
        minTemperatureLabel.text = "\(forecastday.day.mintempC)°C"
        conditionLabel.text = "\(forecastday.day.condition.text)"
        conditionIcon.sd_setImage(with: URL(string: "https:\(forecastday.day.condition.icon)"), placeholderImage: UIImage(#imageLiteral(resourceName: "partly_cloudy")))
        self.rowViewModel = rowViewModel
    }
}
