//
//  CityTableViewCell.swift
//  weather-forecast-ios
//
//  Created by Laxman on 18/09/24.
//

import UIKit

class CityTableViewCell: BaseTableViewCell {
    static let identifier = "CityTableViewCell"
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
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
        guard let city = rowViewModel.data as? SearchCity else { return }
        locationLabel.text = "\(city.name), \(city.region), \(city.country)"
        latLabel.text = "\(city.lat)"
        lonLabel.text = "\(city.lon)"
        self.rowViewModel = rowViewModel
    }
}
