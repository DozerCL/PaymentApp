//
//  InstallmentViewController.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import UIKit
import RxSwift

internal final class InstallmentViewController: UIViewController {
    private let viewModel: InstallmentViewModel
    private let disposeBag = DisposeBag()
    
    public init(viewModel: InstallmentViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = "Cuotas"
        self.navigationItem.titleView = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        let view = InstallmentView()
        self.view = view
        
        bind(view)
    }
    
    private func bind(_ view: InstallmentView) {
        let installmentSelected = PublishSubject<PayerCost>()
        
        let input = viewModel.inputType.init(viewDidLoad: rx.viewDidLoad.asObservable(),
                                             installmentSelected: installmentSelected,
                                             finishButtonTap: view.finishButton.rx.tap.asObservable())
        
        let output = viewModel.transform(input)
        
        output.bankName
            .bind(to: view.bankNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: view.installmentTableView.rx.items) { tableView, row, item -> UITableViewCell in
                let cell: InstallmentCell = tableView.deqeue(cellFor: IndexPath(row: row, section: 0))
                cell.configure(description: item.recommended_message)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.finishButtonEnabled
            .bind(to: view.finishButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        view.installmentTableView.rx.modelSelected(PayerCost.self)
            .bind(to: installmentSelected)
            .disposed(by: disposeBag)
    }
}
