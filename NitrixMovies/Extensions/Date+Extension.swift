//
//  Date+Extension.swift
//  NitrixMovies
//
//  Created by  Toropov Oleksandr on 04.02.2024.
//

import Foundation

extension Date {
    
    func formatted() -> String {
        return DateFormatter
            .customFormat
            .string(from: self)
    }

}
