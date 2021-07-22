//
//  DetailsViewModel.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import RxSwift

public final class DetailsViewModel: ViewModel {
    public struct Input {
        public init() {}
    }
    
    public struct Output {
        public let amount: Observable<String>
        public let paymentMethod: Observable<String>
        public let bank: Observable<String>
        public let installment: Observable<String>
    }
    
    public struct Delegate {}
    
    public let delegate = Delegate()
    private let amount: String
    private let paymentMethod: String
    private let bank: String
    private let installment: String
    
    public init(amount: String,
                paymentMethod: String,
                bank: String,
                installment: String) {
        self.amount = amount
        self.paymentMethod = paymentMethod
        self.bank = bank
        self.installment = installment
    }
    
    public func transform(_ input: Input) -> Output {
        return Output(amount: .just(amount),
                      paymentMethod: .just(paymentMethod),
                      bank: .just(bank),
                      installment: .just(installment))
    }
}
