//
//  String+Extensions.swift
//  iTunesSearch
//
//  Created by Dağhan Kılıçay on 21.01.2021.
//

import Foundation

extension String {
    
    func formatSearchDate() -> String? {
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.timeZone = TimeZone(identifier: "Europe/Istanbul")
        
        guard let date = dateFormatter.date(from: self) else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            guard let date2 = dateFormatter.date(from: self) else {
                return nil
            }
            let calendar = Calendar.current
            guard let newDate = calendar.date(byAdding: .hour, value: 3, to: date2) else {return nil}
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: newDate)
        }
        
        let calendar = Calendar.current
        guard let newDate = calendar.date(byAdding: .hour, value: 3, to: date) else {return nil}
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: newDate)
    }
}
