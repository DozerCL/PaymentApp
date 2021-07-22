//
//  PaymentDataStore.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import RxSwift

public protocol PaymentDataStore {
    var amount: ReplaySubject<Int> { get }
    var paymentMethod: ReplaySubject<PaymentMethod> { get }
    var bank: ReplaySubject<Bank> { get }
    var installment: ReplaySubject<PayerCost> { get }
}

public class PaymentDataStoreImpl: PaymentDataStore {
    public let amount: ReplaySubject<Int>
    public let paymentMethod: ReplaySubject<PaymentMethod>
    public let bank: ReplaySubject<Bank>
    public let installment: ReplaySubject<PayerCost>
    
    public init() {
        amount = ReplaySubject<Int>.create(bufferSize: 1)
        paymentMethod = ReplaySubject<PaymentMethod>.create(bufferSize: 1)
        bank = ReplaySubject<Bank>.create(bufferSize: 1)
        installment = ReplaySubject<PayerCost>.create(bufferSize: 1)
    }
}
