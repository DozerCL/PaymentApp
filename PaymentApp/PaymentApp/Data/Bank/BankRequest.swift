//
//  BankRequest.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

public struct BankRequest: HttpRequest {
    public var path: String {
        "v1/payment_methods/card_issuers?public_key=\(Configuration.apiKey)&" +
        "payment_method_id=\(paymentMethodId)"
    }
    public let method: String = "GET"
    public let paymentMethodId: String
    
    public init(paymentMethodId: String) {
        self.paymentMethodId = paymentMethodId
    }
}
