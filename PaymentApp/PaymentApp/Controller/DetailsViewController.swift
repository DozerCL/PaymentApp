//
//  DetailsViewController.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import UIKit
import RxSwift

internal final class DetailsViewController: UIViewController {
    private let viewModel: DetailsViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let view = DetailsView()
        self.view = view
        
        bind(view)
    }
    
    private func bind(_ view: DetailsView) {
        let input = viewModel.inputType.init()
        
        let output = viewModel.transform(input)
        
        output.amount
            .bind(to: view.amountLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.paymentMethod
            .bind(to: view.paymentMethodLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.bank
            .bind(to: view.bankLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.installment
            .bind(to: view.installmentLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
