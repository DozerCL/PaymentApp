//
//  Int+Extension.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import Foundation

public extension Int {
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
