//
//  PaymentViewController.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import UIKit
import RxSwift

internal final class PaymentViewController: UIViewController {
    private let viewModel: PaymentViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: PaymentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Medio de pago"
        self.navigationItem.titleView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let view = PaymentView()
        self.view = view
        
        bind(view)
    }
    
    private func bind(_ view: PaymentView) {
        let paymentMethodSelected = PublishSubject<PaymentMethod>()
        
        let input = viewModel.inputType.init(viewDidLoad: rx.viewDidLoad.asObservable(),
                                             paymentMethodSelected: paymentMethodSelected,
                                             nextButtonTap: view.nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.amount
            .bind(to: view.amountLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: view.paymentMethodTableView.rx.items) { tableView, row, item -> UITableViewCell in
                let cell: PaymentMethodCell = tableView.deqeue(cellFor: IndexPath(row: row, section: 0))
                cell.configure(urlString: item.secure_thumbnail, name: item.name)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.nextButtonEnabled
            .bind(to: view.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        view.paymentMethodTableView.rx.modelSelected(PaymentMethod.self)
            .bind(to: paymentMethodSelected)
            .disposed(by: disposeBag)
    }
}
