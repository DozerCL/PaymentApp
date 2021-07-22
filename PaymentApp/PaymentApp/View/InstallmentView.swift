//
//  InstallmentView.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import UIKit
import PureLayout

public final class InstallmentView: UIView {
    public let bankNameLabel = UILabel()
    public let installmentTableView = UITableView()
    public let finishButton = UIButton()
    
    private let bankTitleLabel = UILabel()
    private let tableTitleLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        installmentTableView.register(cell: InstallmentCell.self)
        installmentTableView.separatorStyle = .none
        
        bankTitleLabel.text = "Banco seleccionado"
        bankNameLabel.font = UIFont.boldSystemFont(ofSize: 32)
        bankNameLabel.adjustsFontSizeToFitWidth = true
        bankNameLabel.textAlignment = .center
        
        tableTitleLabel.text = "Selecciona las cuotas"
        
        finishButton.setTitle("Finalizar", for: .normal)
        finishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        finishButton.setTitleColor(.blue, for: .normal)
        finishButton.setTitleColor(.lightGray, for: .highlighted)
        finishButton.setTitleColor(.gray, for: .disabled)
    }
    
    private func layout() {
        backgroundColor = .white
        
        addSubview(bankTitleLabel)
        bankTitleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 32)
        bankTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(bankNameLabel)
        bankNameLabel.autoPinEdge(.top, to: .bottom, of: bankTitleLabel, withOffset: 8)
        bankNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        bankNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        
        addSubview(tableTitleLabel)
        tableTitleLabel.autoPinEdge(.top, to: .bottom, of: bankNameLabel, withOffset: 32)
        tableTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(finishButton)
        finishButton.autoSetDimensions(to: .init(width: 120, height: 48))
        finishButton.autoAlignAxis(toSuperviewAxis: .vertical)
        finishButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16)
        
        addSubview(installmentTableView)
        installmentTableView.autoPinEdge(.top, to: .bottom, of: tableTitleLabel, withOffset: 16)
        installmentTableView.autoPinEdge(toSuperviewEdge: .left)
        installmentTableView.autoPinEdge(toSuperviewEdge: .right)
        installmentTableView.autoPinEdge(.bottom, to: .top, of: finishButton, withOffset: -16)
    }
}
