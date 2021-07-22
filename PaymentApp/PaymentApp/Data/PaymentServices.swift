//
//  PaymentServices.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 20-07-21.
//

import RxSwift

public protocol PaymentServices {
    var requestExecutor: RequestExecutor { get }
    
    func paymentMethods() -> Single<[PaymentMethod]>
    func banks(paymentMethodId: String) -> Single<[Bank]>
    func installments(paymentMethodId: String, issuerId: String, amount: Int) -> Single<[Installment]>
}

public final class PaymentServicesImpl: PaymentServices {
    public var requestExecutor: RequestExecutor = RequestExecutorImpl()
    
    public func paymentMethods() -> Single<[PaymentMethod]> {
        return requestExecutor.execute(request: PaymentMethodRequest())
    }
    
    public func banks(paymentMethodId: String) -> Single<[Bank]> {
        return requestExecutor.execute(request: BankRequest(paymentMethodId: paymentMethodId))
    }
    
    public func installments(paymentMethodId: String,
                             issuerId: String,
                             amount: Int) -> Single<[Installment]> {
        return requestExecutor.execute(request: InstallmentRequest(paymentMethodId: paymentMethodId,
                                                                   issuerId: issuerId,
                                                                   amount: amount))
    }
}
