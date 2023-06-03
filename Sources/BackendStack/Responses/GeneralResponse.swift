//
//  GeneralResponse.swift
//  
//
//  Created by Joe Maghzal on 03/06/2023.
//

import Vapor

public struct GeneralResponse<T: Content> {
//MARK: - Properties
    public var status: HTTPStatus
    public var headers = Configurations.shared.defaultHeaders
    public var visible: GeneralVisibleResponse<T>
//MARK: - Initializer
    public init(status: HTTPStatus, headers: HTTPHeaders? = nil, visible: GeneralVisibleResponse<T>) {
        self.status = status
        self.headers = headers ?? Configurations.shared.defaultHeaders
        self.visible = visible
    }
}

//MARK: - Functions
public extension GeneralResponse {
    static func error(_ error: GeneralError?) -> GeneralResponse<T> {
        return GeneralResponse(status: error?.status ?? .notFound, visible: .error(error))
    }
    static func error(_ error: AbortError?) -> GeneralResponse<T> {
        return GeneralResponse(status: error?.status ?? .notFound, visible: .error(error))
    }
    static func error(_ error: Error?) -> GeneralResponse<T> {
        return GeneralResponse(status: .notFound, visible: .error(error))
    }
}

//MARK: - AsyncResponseEncodable
extension GeneralResponse: AsyncResponseEncodable {
    public func encodeResponse(for request: Request) async throws -> Response {
        let encoder = Configurations.shared.encoder
        var newVisible = visible
        if newVisible.error == true {
            return Response(status: status, version: Configurations.shared.httpVersion, headers: headers, body: .init(data: try encoder.encode(newVisible)))
        }else if let data = newVisible.data {
            return Response(status: status, version: Configurations.shared.httpVersion, headers: headers, body: .init(data: try encoder.encode(data)))
        }
        newVisible.action = nil
        newVisible.error = nil
        return Response(status: status, version: Configurations.shared.httpVersion, headers: headers, body: .init(data: try encoder.encode(newVisible)))
    }
}
