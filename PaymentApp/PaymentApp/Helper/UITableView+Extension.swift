//
//  UITableView+Extension.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(cell type: T.Type) {
        register(type, forCellReuseIdentifier: String(describing: T.self))
    }

    func deqeue<T: UITableViewCell>(cellFor indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
}
