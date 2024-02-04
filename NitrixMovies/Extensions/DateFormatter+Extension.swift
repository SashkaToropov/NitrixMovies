//
//  DateFormatter+Extension.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import Foundation

extension DateFormatter {
    
        static let customFormat: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM YYYY"
            return formatter
        }()
}
