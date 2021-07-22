//
//  PaymentMethodRequest.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

public struct PaymentMethodRequest: HttpRequest {
    public let path: String = "v1/payment_methods?public_key=\(Configuration.apiKey)"
    public let method: String = "GET"
}
