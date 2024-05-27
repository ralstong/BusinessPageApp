//
//  StringExtension.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/23/24.
//

import Foundation

extension String {
    func dateFromHMSTime() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.date(from: self)
    }
    
    func convertToFullWeekday() -> String? {
        let short = self.uppercased()
        let inputDF = DateFormatter()
        inputDF.dateFormat = "EEE"
        guard let inputDate = inputDF.date(from: short) else {
            return nil
        }
        let outputDF = DateFormatter()
        outputDF.dateFormat = "EEEE"
        return outputDF.string(from: inputDate)
    }
}
