//
//  RowViewModel.swift
//  weather-forecast-ios
//
//  Created by Laxman on 18/09/24.
//

import UIKit

class RowViewModel {
    var cellIdentifier : String?
    var cellTag : Int?
    var cellIndex : Int?
    var data : Any?
    var isClickable : Bool?
    var corners: UIRectCorner?
    var radius: CGFloat?
    var action: ((_ actionType: Int?,_ data: Any?) -> (Void))?

    internal init(cellIdentifier: String?, cellTag: Int? = nil,cellIndex: Int? = nil, data: Any? = nil, isClickable: Bool? = false,corners: UIRectCorner? = nil,radius: CGFloat? = nil, action: ((_ type: Int?,_ data: Any?) -> (Void))? = nil) {
        self.cellIdentifier = cellIdentifier
        self.cellTag = cellTag
        self.data = data
        self.action = action
        self.isClickable = isClickable
        self.corners = corners
        self.radius = radius
    }
}
