//
//  BankViewModel.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import RxSwift

public final class BankViewModel: ViewModel {
    public struct Input {
        public let viewDidLoad: Observable<Void>
        public let bankSelected: Observable<Bank>
        public let nextButtonTap: Observable<Void>
        
        public init(viewDidLoad: Observable<Void>,
                    bankSelected: Observable<Bank>,
                    nextButtonTap: Observable<Void>) {
            self.viewDidLoad = viewDidLoad
            self.bankSelected = bankSelected
            self.nextButtonTap = nextButtonTap
        }
    }
    
    public struct Output {
        public let paymentMethodName: Observable<String>
        public let items: Observable<[Bank]>
        public let nextButtonEnabled: Observable<Bool>
    }
    
    public struct Delegate {
        public var next: Observable<Void> { return nextSubject.asObservable() }
        fileprivate let nextSubject = PublishSubject<Void>()
    }
    
    public var delegate = Delegate()
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
        
        let paymentMethodName = dataStore.paymentMethod.map({ $0.name })
        
        let items = input.viewDidLoad
            .withLatestFrom(dataStore.paymentMethod.map({ $0.id }))
            .flatMap({
                self.paymentServices.banks(paymentMethodId: $0).map({
                    $0.filter({ $0.status == "active" })
                })
            })
        
        let nextButtonEnabled = input.bankSelected.map({ _ in true })
            .startWith(false)
        
        input.bankSelected
            .bind(to: dataStore.bank)
            .disposed(by: disposeBag)
        
        return Output(paymentMethodName: paymentMethodName,
                      items: items,
                      nextButtonEnabled: nextButtonEnabled)
    }
}
