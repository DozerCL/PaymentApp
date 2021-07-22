//
//  AmountView.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

import UIKit
import PureLayout

public final class AmountView: UIView {
    public let amountTextField = UITextField()
    public let nextButton = UIButton()
    
    private let titleLabel = UILabel()
    private let dollarSignLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.text = "Ingresa un monto:"
        
        dollarSignLabel.text = "$"
        
        amountTextField.borderStyle = .roundedRect
        amountTextField.keyboardType = .numberPad
        amountTextField.leftView = dollarSignLabel
        amountTextField.leftViewMode = .always
        amountTextField.placeholder = "0"
        amountTextField.delegate = self
        
        nextButton.setTitle("Siguiente", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextButton.setTitleColor(.blue, for: .normal)
        nextButton.setTitleColor(.lightGray, for: .highlighted)
        nextButton.setTitleColor(.gray, for: .disabled)
    }
    
    private func layout() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 80)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        
        addSubview(amountTextField)
        amountTextField.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 16)
        amountTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        amountTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        
        addSubview(nextButton)
        nextButton.autoSetDimension(.height, toSize: 48)
        nextButton.autoPinEdge(.top, to: .bottom, of: amountTextField, withOffset: 64)
        nextButton.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        nextButton.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
    }
}

extension AmountView: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count >= 9 && !string.isEmpty { return false }
        if textField.text!.isEmpty && string == "0" { return false }
        return string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil || string.isEmpty
    }
}
