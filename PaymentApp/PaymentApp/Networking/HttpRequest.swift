//
//  HttpRequest.swift
//  PaymentApp
//
//  Created by Kevin Ignacio Delgado Jimenez on 20-07-21.
//

import Foundation

public protocol HttpRequest {
    var path: String { get }
    var method: String { get }
}
