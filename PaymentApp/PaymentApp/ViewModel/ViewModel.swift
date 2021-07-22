//
//  ViewModel.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 19-07-21.
//

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    associatedtype Delegate

    var inputType: Input.Type { get }
    var delegate: Delegate { get }

    func transform(_ input: Input) -> Output
}

public extension ViewModel {
    var inputType: Input.Type { return Input.self }
}
