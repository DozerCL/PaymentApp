//
//  InstallmentRequest.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

public struct InstallmentRequest: HttpRequest {
    public var path: String {
        "v1/payment_methods/installments?public_key=\(Configuration.apiKey)&" +
        "payment_method_id=\(paymentMethodId)&" +
        "issuer.id=\(issuerId)&" +
        "amount=\(amount)"
    }
    public var method: String = "GET"
    public let paymentMethodId: String
    public let issuerId: String
    public let amount: Int
    
    public init(paymentMethodId: String,
                issuerId: String,
                amount: Int) {
        self.paymentMethodId = paymentMethodId
        self.issuerId = issuerId
        self.amount = amount
    }
}
