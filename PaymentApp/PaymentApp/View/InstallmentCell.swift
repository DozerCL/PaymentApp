//
//  InstallmentCell.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import UIKit
import Kingfisher

public final class InstallmentCell: UITableViewCell {
    private let wrapper = UIView()
    private let installmentLabel = UILabel()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            accessoryType = .checkmark
            installmentLabel.textColor = .blue
        } else {
            accessoryType = .none
            installmentLabel.textColor = .black
        }
    }
    
    public func configure(description: String) {
        self.installmentLabel.text = description
    }
    
    private func setup() {
        selectionStyle = .none
        installmentLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    private func layout() {
        contentView.addSubview(wrapper)
        wrapper.autoPinEdgesToSuperviewEdges()
        
        wrapper.addSubview(installmentLabel)
        installmentLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        installmentLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        installmentLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        installmentLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
    }
}
