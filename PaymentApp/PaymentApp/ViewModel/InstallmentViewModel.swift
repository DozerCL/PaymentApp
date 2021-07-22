//
//  InstallmentViewModel.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import RxSwift

public final class InstallmentViewModel: ViewModel {
    public struct Input {
        public let viewDidLoad: Observable<Void>
        public let installmentSelected: Observable<PayerCost>
        public let finishButtonTap: Observable<Void>
        
        public init(viewDidLoad: Observable<Void>,
                    installmentSelected: Observable<PayerCost>,
                    finishButtonTap: Observable<Void>) {
            self.viewDidLoad = viewDidLoad
            self.installmentSelected = installmentSelected
            self.finishButtonTap = finishButtonTap
        }
    }
    
    public struct Output {
        public let bankName: Observable<String>
        public let items: Observable<[PayerCost]>
        public let finishButtonEnabled: Observable<Bool>
    }
    
    public struct Delegate {
        public var finish: Observable<Void> { return finishSubject.asObservable() }
        fileprivate let finishSubject = PublishSubject<Void>()
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
        input.finishButtonTap
            .bind(to: delegate.finishSubject)
            .disposed(by: disposeBag)
        
        let bankName = dataStore.bank.map({ $0.name })
        
        let values = Observable.combineLatest(
            dataStore.paymentMethod.map({ $0.id }),
            dataStore.bank.map({ $0.id }),
            dataStore.amount
        )
        
        let items = input.viewDidLoad
            .withLatestFrom(values)
            .flatMap({
                self.paymentServices.installments(paymentMethodId: $0, issuerId: $1, amount: $2).compactMap({
                    $0.first?.payer_costs
                })
            })
        
        let finishButtonEnabled = input.installmentSelected.map({ _ in true })
            .startWith(false)
        
        input.installmentSelected
            .bind(to: dataStore.installment)
            .disposed(by: disposeBag)
        
        return Output(bankName: bankName,
                      items: items,
                      finishButtonEnabled: finishButtonEnabled)
    }
}
