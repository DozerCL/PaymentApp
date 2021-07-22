//
//  DetailsView.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import UIKit
import PureLayout

public final class DetailsView: UIView {
    public let amountLabel = UILabel()
    public let paymentMethodLabel = UILabel()
    public let bankLabel = UILabel()
    public let installmentLabel = UILabel()
    
    private let screenTitle = UILabel()
    private let amountTitle = UILabel()
    private let paymentMethodTitle = UILabel()
    private let bankTitle = UILabel()
    private let installmentTitle = UILabel()
    
    public init() {
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        screenTitle.text = "¡Gracias!"
        screenTitle.font = UIFont.boldSystemFont(ofSize: 32)
        
        amountTitle.text = "Monto a pagar"
        amountTitle.textAlignment = .center
        amountTitle.font = .systemFont(ofSize: 16)
        
        paymentMethodTitle.text = "Medio de pago"
        paymentMethodTitle.textAlignment = .center
        paymentMethodTitle.font = .systemFont(ofSize: 16)
        
        bankTitle.text = "Banco"
        bankTitle.textAlignment = .center
        bankTitle.font = .systemFont(ofSize: 16)
        
        installmentTitle.text = "Cuotas"
        installmentTitle.textAlignment = .center
        installmentTitle.font = .systemFont(ofSize: 16)
        
        amountLabel.font = .boldSystemFont(ofSize: 24)
        amountLabel.textAlignment = .center
        paymentMethodLabel.font = .boldSystemFont(ofSize: 24)
        paymentMethodLabel.adjustsFontSizeToFitWidth = true
        paymentMethodLabel.textAlignment = .center
        bankLabel.font = .boldSystemFont(ofSize: 24)
        bankLabel.adjustsFontSizeToFitWidth = true
        bankLabel.textAlignment = .center
        installmentLabel.font = .boldSystemFont(ofSize: 24)
        installmentLabel.adjustsFontSizeToFitWidth = true
        installmentLabel.textAlignment = .center
    }
    
    private func layout() {
        backgroundColor = .white
        
        addSubview(screenTitle)
        screenTitle.autoPinEdge(toSuperviewSafeArea: .top, withInset: 32)
        screenTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(amountTitle)
        amountTitle.autoPinEdge(.top, to: .bottom, of: screenTitle, withOffset: 32)
        amountTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(amountLabel)
        amountLabel.autoPinEdge(.top, to: .bottom, of: amountTitle, withOffset: 8)
        amountLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(paymentMethodTitle)
        paymentMethodTitle.autoPinEdge(.top, to: .bottom, of: amountLabel, withOffset: 32)
        paymentMethodTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(paymentMethodLabel)
        paymentMethodLabel.autoPinEdge(.top, to: .bottom, of: paymentMethodTitle, withOffset: 8)
        paymentMethodLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        paymentMethodLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        paymentMethodLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(bankTitle)
        bankTitle.autoPinEdge(.top, to: .bottom, of: paymentMethodLabel, withOffset: 32)
        bankTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(bankLabel)
        bankLabel.autoPinEdge(.top, to: .bottom, of: bankTitle, withOffset: 8)
        bankLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        bankLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        bankLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(installmentTitle)
        installmentTitle.autoPinEdge(.top, to: .bottom, of: bankLabel, withOffset: 32)
        installmentTitle.autoAlignAxis(toSuperviewAxis: .vertical)
        
        addSubview(installmentLabel)
        installmentLabel.autoPinEdge(.top, to: .bottom, of: installmentTitle, withOffset: 8)
        installmentLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        installmentLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        installmentLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
