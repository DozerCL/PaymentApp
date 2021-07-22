//
//  BankViewController.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import UIKit
import RxSwift

internal final class BankViewController: UIViewController {
    private let viewModel: BankViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: BankViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Banco"
        self.navigationItem.titleView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let view = BankView()
        self.view = view
        
        bind(view)
    }
    
    private func bind(_ view: BankView) {
        let bankSelected = PublishSubject<Bank>()
        
        let input = viewModel.inputType.init(viewDidLoad: rx.viewDidLoad.asObservable(),
                                             bankSelected: bankSelected,
                                             nextButtonTap: view.nextButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.paymentMethodName
            .bind(to: view.paymentMethodNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: view.bankTableView.rx.items) { tableView, row, item -> UITableViewCell in
                let cell: BankCell = tableView.deqeue(cellFor: IndexPath(row: row, section: 0))
                cell.configure(urlString: item.secure_thumbnail, name: item.name)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.nextButtonEnabled
            .bind(to: view.nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        view.bankTableView.rx.modelSelected(Bank.self)
            .bind(to: bankSelected)
            .disposed(by: disposeBag)
    }
}
