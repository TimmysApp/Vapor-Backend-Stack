//
//  Configurations.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Foundation
import Vapor

public struct Configurations {
//MARK: - Properties
    public static var shared = Configurations()
    var defaultHeaders = HTTPHeaders()
    var mapUnauthorised: (() -> GeneralError)?
    var httpVersion = HTTPVersion.http3
    var encoder = JSONEncoder()
//MARK: - Functions
    public static func onAuthorisationError(_ acion: @escaping () -> GeneralError) {
        shared.mapUnauthorised = acion
    }
    public static func onAuthorisationError(_ error: GeneralError) {
        shared.mapUnauthorised = {
            return error
        }
    }
    public static func set(version: HTTPVersion) {
        shared.httpVersion = version
    }
    public static func set(encoder: JSONEncoder) {
        shared.encoder = encoder
    }
    public static func set(defaultHeaders: HTTPHeaders) {
        shared.defaultHeaders = defaultHeaders
    }
}
