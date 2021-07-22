//
//  PaymentViewModel.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import Foundation
import RxSwift

public final class PaymentViewModel: ViewModel {
    public struct Input {
        public let viewDidLoad: Observable<Void>
        public let paymentMethodSelected: Observable<PaymentMethod>
        public let nextButtonTap: Observable<Void>
        
        public init(viewDidLoad: Observable<Void>,
                    paymentMethodSelected: Observable<PaymentMethod>,
                    nextButtonTap: Observable<Void>) {
            self.viewDidLoad = viewDidLoad
            self.paymentMethodSelected = paymentMethodSelected
            self.nextButtonTap = nextButtonTap
        }
    }
    
    public struct Output {
        public let amount: Observable<String>
        public let items: Observable<[PaymentMethod]>
        public let nextButtonEnabled: Observable<Bool>
    }
    
    public struct Delegate {
        public var next: Observable<Void> { return nextSubject.asObservable() }
        fileprivate let nextSubject = PublishSubject<Void>()
    }
    
    public let delegate = Delegate()
    private let paymentServices: PaymentServices
    private let dataStore: PaymentDataStore
    private let disposeBag = DisposeBag()
    
    public init(paymentServices: PaymentServices,
                dataStore: PaymentDataStore) {
        self.paymentServices = paymentServices
        self.dataStore = dataStore
    }
    
    public func transform(_ input: Input) -> Output {
        input.nextButtonTap
            .bind(to: delegate.nextSubject)
            .disposed(by: disposeBag)
        
        let amountDescription = dataStore.amount.map({
            $0.toCurrency()
        })
        
        let items = input.viewDidLoad.flatMap({
            self.paymentServices.paymentMethods().map({
                $0.filter({ $0.status == "active" && $0.payment_type_id == "credit_card"})
            })
        })
        
        let nextButtonEnabled = input.paymentMethodSelected.map({ _ in true })
            .startWith(false)
        
        input.paymentMethodSelected
            .bind(to: dataStore.paymentMethod)
            .disposed(by: disposeBag)
        
        return Output(amount: amountDescription,
                      items: items,
                      nextButtonEnabled: nextButtonEnabled)
    }
}
