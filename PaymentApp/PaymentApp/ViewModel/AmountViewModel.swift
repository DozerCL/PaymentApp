//
//  AmountViewModel.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import RxSwift

public final class AmountViewModel: ViewModel {
    public struct Input {
        public let amount: Observable<String>
        public let nextTap: Observable<Void>
        
        public init(amount: Observable<String>,
                    nextTap: Observable<Void>) {
            self.amount = amount
            self.nextTap = nextTap
        }
    }
    
    public struct Output {
        public let nextButtonEnabled: Observable<Bool>
    }
    
    public struct Delegate {
        public var next: Observable<Void> { return nextSubject.asObservable() }
        fileprivate let nextSubject = PublishSubject<Void>()
    }
    
    public let delegate = Delegate()
    private let dataStore: PaymentDataStore
    private let disposeBag = DisposeBag()
    
    public init(dataStore: PaymentDataStore) {
        self.dataStore = dataStore
    }
    
    public func transform(_ input: Input) -> Output {
        input.nextTap
            .bind(to: delegate.nextSubject)
            .disposed(by: disposeBag)
        
        let amount = input.amount.map({ return Int($0) ?? 0 })
        
        let nextButtonEnabled = amount.map({ $0 > 0 })
        
        amount.bind(to: dataStore.amount)
            .disposed(by: disposeBag)
        
        return Output(
            nextButtonEnabled: nextButtonEnabled
        )
    }
}
