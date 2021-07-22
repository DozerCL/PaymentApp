//
//  PaymentMethod.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

public struct PaymentMethod: Codable {
    let id: String
    let name: String
    let payment_type_id: String
    let status: String
    let secure_thumbnail: String
}
