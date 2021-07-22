//
//  PaymentMethodCell.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import UIKit
import Kingfisher

public final class PaymentMethodCell: UITableViewCell {
    private let wrapper = UIView()
    private let paymentImageView = UIImageView()
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
            self.paymentImageView.kf.setImage(with: url)
        }
        self.nameLabel.text = name
    }
    
    private func setup() {
        selectionStyle = .none
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        paymentImageView.contentMode = .scaleAspectFit
    }
    
    private func layout() {
        contentView.addSubview(wrapper)
        wrapper.autoPinEdgesToSuperviewEdges()
        
        wrapper.addSubview(paymentImageView)
        paymentImageView.autoSetDimensions(to: .init(width: 40, height: 40))
        paymentImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        paymentImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 8)
        paymentImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        paymentImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        wrapper.addSubview(nameLabel)
        nameLabel.autoPinEdge(.left, to: .right, of: paymentImageView, withOffset: 8)
        nameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
