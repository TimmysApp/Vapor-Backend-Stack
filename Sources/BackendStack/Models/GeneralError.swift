//
//  GeneralError.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Vapor

public protocol GeneralError: AbortError {
    var reason: String {get}
    var description: String {get}
    var status: HTTPStatus {get}
    var action: ResponseActionable? {get}
}

public extension GeneralError {
    var action: ResponseActionable? {
        return nil
    }
}

public protocol ResponseActionable {
    var id: Int {get}
}
