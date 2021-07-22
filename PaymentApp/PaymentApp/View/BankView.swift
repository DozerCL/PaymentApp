//
//  BankView.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import UIKit
import PureLayout

public final class BankView: UIView {
    public let paymentMethodNameLabel = UILabel()
    public let bankTableView = UITableView()
    public let nextButton = UIButton()
    
    private let paymentMethodTitleLabel = UILabel()
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
        bankTableView.register(cell: BankCell.self)
        bankTableView.separatorStyle = .none
        
        paymentMethodTitleLabel.text = "Medio de pago seleccionado"
        paymentMethodNameLabel.font = UIFont.boldSystemFont(ofSize: 32)
        paymentMethodNameLabel.adjustsFontSizeToFitWidth = true
        paymentMethodNameLabel.textAlignment = .center
        
        tableTitleLabel.text = "Selecciona un banco"
        
        nextButton.setTitle("Siguiente", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.setTitleColor(.blue, for: .normal)
        nextButton.setTitleColor(.lightGray, for: .highlighted)
        nextButton.setTitleColor(.gray, for: .disabled)
    }
    
    private func layout() {
        backgroundColor = .white
        
        addSubview(paymentMethodTitleLabel)
        paymentMethodTitleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 32)
        paymentMethodTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(paymentMethodNameLabel)
        paymentMethodNameLabel.autoPinEdge(.top, to: .bottom, of: paymentMethodTitleLabel, withOffset: 8)
        paymentMethodNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        paymentMethodNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        
        addSubview(tableTitleLabel)
        tableTitleLabel.autoPinEdge(.top, to: .bottom, of: paymentMethodNameLabel, withOffset: 32)
        tableTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(nextButton)
        nextButton.autoSetDimensions(to: .init(width: 120, height: 48))
        nextButton.autoAlignAxis(toSuperviewAxis: .vertical)
        nextButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16)
        
        addSubview(bankTableView)
        bankTableView.autoPinEdge(.top, to: .bottom, of: tableTitleLabel, withOffset: 16)
        bankTableView.autoPinEdge(toSuperviewEdge: .left)
        bankTableView.autoPinEdge(toSuperviewEdge: .right)
        bankTableView.autoPinEdge(.bottom, to: .top, of: nextButton, withOffset: -16)
    }
}
