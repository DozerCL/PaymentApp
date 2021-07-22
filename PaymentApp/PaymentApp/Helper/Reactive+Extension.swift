//
//  Reactive+Extension.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 21-07-21.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIViewController {
    var viewDidLoad: ControlEvent<Void> {
        let source = methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }
}
