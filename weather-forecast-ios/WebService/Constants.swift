//
//  SharedConfig.swift
//  weather-forecast-ios
//
//  Created by ِLaxman on 16/09/24.
//

import UIKit
import LocalAuthentication


class Constants: NSObject {
    
    private override init() {}
    
    // MARK: - Colors
    struct colors {
        static let red = #colorLiteral(red: 0.9568627451, green: 0.2588235294, blue: 0.2588235294, alpha: 1)
        static let lightRed = #colorLiteral(red: 0.9546490312, green: 0.2583815455, blue: 0.2611953318, alpha: 0.08141588183)
        static let darkRed = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
        static let black = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        static let white = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let transWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        static let transWhite2 = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.72)
        static let gray = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        static let lightGray = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        static let veryLightGray = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        static let grayWithOp = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 0.9)
        static let loadingGray = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        static let viewGrayBackground = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        static let viewGrayBackgroundLite = #colorLiteral(red: 0.905, green: 0.905, blue: 0.905, alpha: 1)
        static let loading = [#colorLiteral(red: 0.9098039216, green: 0.1215686275, blue: 0.7137254902, alpha: 0.2),#colorLiteral(red: 0.908824861, green: 0.1204800233, blue: 0.7127839923, alpha: 0.2),#colorLiteral(red: 0.908824861, green: 0.1204800233, blue: 0.7127839923, alpha: 0.2)]
        static let lightDuBarneyColor = #colorLiteral(red: 0.7803921569, green: 0.1411764706, blue: 0.6941176471, alpha: 0.7)
        static let purple = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 1)
        static let orange = #colorLiteral(red: 1, green: 0.5098039216, blue: 0, alpha: 1)
        static let loadingSms = [#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.2),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.2),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.2)]
        static let loadingVoice = [#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 0.2),#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 0.2),#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 0.2)]
        static let lightYellow = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.1)
        static let buttonGray = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        static let timelineLightGray = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        static let borderColor = #colorLiteral(red: 0.867, green: 0.867, blue: 0.867, alpha: 1)
        static let border = #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        static let winsFirstColor = #colorLiteral(red: 0.7803921569, green: 0.5058823529, blue: 0.007843137255, alpha: 1)
        static let winsSecondColor = #colorLiteral(red: 1, green: 0.7529411765, blue: 0.2470588235, alpha: 1)
                
    }

    static let slowGradientDuration: Double = 4
    static let buttonGradientDuration: Double = 2
    static let backgroundGradientAngle: CGFloat = 45
    static let buttonGradientAngle: CGFloat = 9.516

    
    
    // MARK: - Urls
    struct urls {

        static var baseUrl: String {
            return "https://api.weatherapi.com/v1/"
        }
    }
    
    // MARK: - Strings
    struct strings {

        static let apiKey = "16de155b51d043d3b45142204241609"
    }
    
    struct errors {
        
        /// General parsing error
        static var unknownErrorCode = 32234
        static var parsingErrorCode = 455432
        static var doNothingCode = 34546
        
    }

}
    



