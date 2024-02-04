//
//  String+Extension.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
}
