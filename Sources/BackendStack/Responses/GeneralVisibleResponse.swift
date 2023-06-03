//
//  GeneralVisibleResponse.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Foundation
import Vapor

public struct GeneralVisibleResponse<T: Content>: Content {
//MARK: - Properties
    var error: Bool?
    var message: String?
    var summary: String?
    var action: Int?
    var data: T?
}

//MARK: - Functions
public extension GeneralVisibleResponse {
    static func error(_ error: GeneralError?) -> GeneralVisibleResponse<T> {
        return GeneralVisibleResponse(error: true, message: error?.reason, summary: error?.description, action: error?.action?.id, data: nil)
    }
    static func error(_ error: AbortError?) -> GeneralVisibleResponse<T> {
        return GeneralVisibleResponse(error: true, message: error?.reason, summary: nil, data: nil)
    }
    static func error(_ error: Error?) -> GeneralVisibleResponse<T> {
        return GeneralVisibleResponse(error: true, message: error?.localizedDescription, summary: nil, data: nil)
    }
    static func success(_ data: T, message: String? = nil, summary: String? = nil, action: ResponseActionable? = nil) -> GeneralVisibleResponse<T> {
        return GeneralVisibleResponse(error: false, message: message, summary: summary, action: action?.id, data: data)
    }
    static func success(message: String? = nil, summary: String? = nil, action: ResponseActionable? = nil) -> GeneralVisibleResponse<T> {
        return GeneralVisibleResponse(error: false, message: message, summary: summary, action: action?.id, data: nil)
    }
}
