//
//  BankCell.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 22-07-21.
//

import UIKit
import Kingfisher

public final class BankCell: UITableViewCell {
    private let wrapper = UIView()
    private let bankImageView = UIImageView()
    private let nameLabel = UILabel()
    
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
        } else {
            accessoryType = .none
        }
    }
    
    public func configure(urlString: String, name: String) {
        if let url = URL(string: urlString) {
            self.bankImageView.kf.setImage(with: url)
        }
        self.nameLabel.text = name
    }
    
    private func setup() {
        selectionStyle = .none
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        bankImageView.contentMode = .scaleAspectFit
    }
    
    private func layout() {
        contentView.addSubview(wrapper)
        wrapper.autoPinEdgesToSuperviewEdges()
        
        wrapper.addSubview(bankImageView)
        bankImageView.autoSetDimensions(to: .init(width: 40, height: 40))
        bankImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        bankImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        bankImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        bankImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        wrapper.addSubview(nameLabel)
        nameLabel.autoPinEdge(.left, to: .right, of: bankImageView, withOffset: 8)
        nameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
