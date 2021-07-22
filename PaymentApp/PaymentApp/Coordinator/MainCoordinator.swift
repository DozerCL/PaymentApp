//
//  MainCoordinator.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import UIKit
import RxSwift

internal final class MainCoordinator: Coordinator {
    private let paymentServices: PaymentServices
    private var paymentDataStore: PaymentDataStore = PaymentDataStoreImpl()
    
    private var navigationController: UINavigationController?
    private let disposeBag = DisposeBag()
    
    public init(paymentServices: PaymentServices) {
        self.paymentServices = paymentServices
    }
    
    func start() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController())
        self.navigationController = navigationController
        return navigationController
    }
    
    private func rootViewController() -> UIViewController {
        let viewModel = AmountViewModel(dataStore: paymentDataStore)
        
        viewModel.delegate.next
            .bind(onNext: {
                self.pushPaymentMethodView()
            })
            .disposed(by: disposeBag)
        
        return AmountViewController(viewModel: viewModel)
    }
    
    private func pushPaymentMethodView() {
        let viewModel = PaymentViewModel(paymentServices: paymentServices,
                                         dataStore: paymentDataStore)
        
        viewModel.delegate.next
            .bind(onNext: {
                self.pushBankSelectionView()
            })
            .disposed(by: disposeBag)
        
        let paymentViewController = PaymentViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(paymentViewController, animated: true)
    }
    
    private func pushBankSelectionView() {
        let viewModel = BankViewModel(paymentServices: paymentServices,
                                      dataStore: paymentDataStore)
        
        viewModel.delegate.next
            .bind(onNext: {
                self.pushInstallmentSelectionView()
            })
            .disposed(by: disposeBag)
        
        let bankViewController = BankViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(bankViewController, animated: true)
    }
    
    private func pushInstallmentSelectionView() {
        let viewModel = InstallmentViewModel(paymentServices: paymentServices,
                                             dataStore: paymentDataStore)
        
        let details = Observable.combineLatest(
            paymentDataStore.amount.map({ $0.toCurrency() }),
            paymentDataStore.paymentMethod.map({ $0.name }),
            paymentDataStore.bank.map({ $0.name }),
            paymentDataStore.installment.map({ $0.recommended_message })
        )
        
        viewModel.delegate.finish
            .withLatestFrom(details)
            .bind(onNext: {
                self.presentDetails(amount: $0, paymentMethod: $1, bank: $2, installments: $3)
            })
            .disposed(by: disposeBag)
        
        let installmentsViewController = InstallmentViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(installmentsViewController, animated: true)
    }
    
    private func presentDetails(amount: String,
                                paymentMethod: String,
                                bank: String,
                                installments: String) {
        let viewModel = DetailsViewModel(amount: amount,
                                         paymentMethod: paymentMethod,
                                         bank: bank,
                                         installment: installments)
        
        let detailsViewController = DetailsViewController(viewModel: viewModel)
        
        self.paymentDataStore = PaymentDataStoreImpl()
        self.navigationController?.viewControllers = [rootViewController()]
        
        self.navigationController?.present(detailsViewController, animated: true, completion: nil)
    }
}
