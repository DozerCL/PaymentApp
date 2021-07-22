//
//  AmountViewController.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import UIKit
import RxSwift

internal final class AmountViewController: UIViewController {
    private let viewModel: AmountViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: AmountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Monto"
        self.navigationItem.titleView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let view = AmountView()
        self.view = view
        
        bind(view)
    }
    
    private func bind(_ view: AmountView) {
        let input = viewModel.inputType.init(
            amount: view.amountTextField.rx.text.orEmpty.asObservable(),
            nextTap: view.nextButton.rx.tap.asObservable()
        )
        
        let output = viewModel.transform(input)
        
        output.nextButtonEnabled
            .bind(to: view.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
