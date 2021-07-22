//
//  PaymentView.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import UIKit
import PureLayout

public class PaymentView: UIView {
    public let amountLabel = UILabel()
    public let paymentMethodTableView = UITableView()
    public let nextButton = UIButton()
    
    private let amountTitleLabel = UILabel()
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
        paymentMethodTableView.register(cell: PaymentMethodCell.self)
        paymentMethodTableView.separatorStyle = .none
        
        amountTitleLabel.text = "Monto a pagar"
        amountTitleLabel.textAlignment = .center
        
        amountLabel.textAlignment = .center
        amountLabel.font = UIFont.boldSystemFont(ofSize: 32)
        
        tableTitleLabel.text = "Selecciona el medio de pago"
        
        nextButton.setTitle("Siguiente", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.setTitleColor(.blue, for: .normal)
        nextButton.setTitleColor(.lightGray, for: .highlighted)
        nextButton.setTitleColor(.gray, for: .disabled)
    }
    
    private func layout() {
        backgroundColor = .white
        
        addSubview(amountTitleLabel)
        amountTitleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 32)
        amountTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(amountLabel)
        amountLabel.autoPinEdge(.top, to: .bottom, of: amountTitleLabel, withOffset: 8)
        amountLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(tableTitleLabel)
        tableTitleLabel.autoPinEdge(.top, to: .bottom, of: amountLabel, withOffset: 32)
        tableTitleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(nextButton)
        nextButton.autoSetDimensions(to: .init(width: 120, height: 48))
        nextButton.autoAlignAxis(toSuperviewAxis: .vertical)
        nextButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 16)
        
        addSubview(paymentMethodTableView)
        paymentMethodTableView.autoPinEdge(.top, to: .bottom, of: tableTitleLabel, withOffset: 16)
        paymentMethodTableView.autoPinEdge(toSuperviewEdge: .left)
        paymentMethodTableView.autoPinEdge(toSuperviewEdge: .right)
        paymentMethodTableView.autoPinEdge(.bottom, to: .top, of: nextButton, withOffset: -16)
    }
}
