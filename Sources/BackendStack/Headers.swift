//
//  Headers.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Foundation
import Vapor

enum HeaderKey: String {
    case deviceModel = "User-Device-Model"
    case deviceID = "User-Device-ID"
    case deviceOS = "User-Device-OS"
}

extension Request {
    func deviceID() throws -> String {
        guard let data = headers.first(name: HeaderKey.deviceID.rawValue) else {
            throw Abort(.forbidden)
        }
        return data
    }
    var deviceModel: String? {
        return headers.first(name: HeaderKey.deviceModel.rawValue)
    }
    var deviceOS: String? {
        return headers.first(name: HeaderKey.deviceOS.rawValue)
    }
}
