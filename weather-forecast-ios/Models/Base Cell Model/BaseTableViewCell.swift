//
//  BaseTableViewCell.swift
//  weather-forecast-ios
//
//  Created by Laxman on 18/09/24.
//

import UIKit

protocol CellConfigurable {
    func setupCell(rowViewModel: RowViewModel)
}

class BaseTableViewCell: UITableViewCell , CellConfigurable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCell(rowViewModel: RowViewModel) {
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		setupViewAccessibility()
	}
}

extension BaseTableViewCell
{
	@objc func setupViewAccessibility() {
	}
}
