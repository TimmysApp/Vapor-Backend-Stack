//
//  ErrorMiddleWare.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Vapor

public class ErrorMiddleWare: AsyncMiddleware {
    public func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        do {
            let response = try await next.respond(to: request)
            return response
        }catch let rawError {
            if let error = rawError as? AbortError {
                return try await GeneralResponse<EmptyData>.error(error).encodeResponse(for: request)
            }else if let error = rawError as? AbortError {
                if error.status == .unauthorized, let error = Configurations.shared.mapUnauthorised?() {
                    return try await GeneralResponse<EmptyData>.error(error).encodeResponse(for: request)
                }
                return try await GeneralResponse<EmptyData>.error(error).encodeResponse(for: request)
            }
            return try await GeneralResponse<EmptyData>.error(rawError).encodeResponse(for: request)
        }
    }
}
