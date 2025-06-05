//
//  DateUtility.swift
//  Sportify
//
//  Created by Abdelaziz on 01/06/2025.
//

import Foundation

class DateUtility {
    static let shared = DateUtility()
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
    func getDateRange(for sport: String, isUpcoming: Bool) -> (from: String, to: String) {
        let currentDate = Date()
        
        switch sport.lowercased() {
        case "cricket", "tennis":
            let fromDate: Date
            let toDate: Date
            if isUpcoming {
                fromDate = currentDate
                toDate = Calendar.current.date(byAdding: .day, value: 30, to: currentDate)!
            } else {
                fromDate = Calendar.current.date(byAdding: .year, value: -3, to: currentDate)!
                toDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
            }
            
            return (formatDate(fromDate), formatDate(toDate))
            
        default:
            let fromDate: Date
            let toDate: Date
            
            if isUpcoming {
                fromDate = currentDate
                toDate = Calendar.current.date(byAdding: .day, value: 15, to: currentDate)!
            }
            else {
                fromDate = Calendar.current.date(byAdding: .day, value: -30, to: currentDate)!
                toDate = currentDate
            }
            
            return (formatDate(fromDate), formatDate(toDate))
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
