//
//  NetworkManager.swift
//  Toranoko
//
//  Created by Mia Milan on 2022/02/04.
//  Copyright © 2022 TORANOTEC K.K. All rights reserved.
//

import Combine
import Foundation
import UIKit

/// Base service that used for Api Calling
/// An extention or viewmodel can user network service
/// With proper endpoint and Generic result type and returns Error on throw
/// By supplying a scheduler it's possible to get response on different thread
class NetworkService {
	private let session: URLSession
	private let scheduler: DispatchQueue

	/// Default decoder for JSONDecoder
	static let decoder: JSONDecoder = {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		jsonDecoder.dateDecodingStrategy = .iso8601
		return jsonDecoder
	}()

	/// Default encoder for JSONEncoder
	static let encoder: JSONEncoder = {
		let jsonEncoder = JSONEncoder()
		jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
		return jsonEncoder
	}()

	init(
		session: URLSession = .shared,
		scheduler: DispatchQueue = DispatchQueue(label: "api_scheduler_network")
	) {
		self.session = session
		self.scheduler = scheduler
	}

	/// Base api response fetcher and decoder
	/// - Parameters:
	///   - endpoint: APICall endpoints
	///   - decoder: accept JSONDecoder, otherwise uses the default one
	/// - Returns: mapped codable items or throws APIError
	func execute<T: Decodable>(endpoint: EndPointType, decoder: JSONDecoder = NetworkService.decoder) async throws -> T {
		let request = try endpoint.asyncRequest()
		let (data, response) = try await URLSession.shared.data(for: request)
		#if DEBUG
		if let response = (response as? HTTPURLResponse) {
			dump(request)
			dump(response)
		}
		#endif
        /// version check error
		if let code = (response as? HTTPURLResponse)?.statusCode, code == 426 {
			throw DecodedErrors.network(description: "\(code)", data: data)
		}
		return try parse(data: data, response: response, decoder: decoder)
	}

	/// parse data from URLSession request response. Helper method for fetch
	/// - Parameters:
	///   - data: Data
	///   - response: URLResponse
	/// - Returns: mapped codable items or throws APIError
	private func parse<T: Decodable>(data: Data, response: URLResponse, decoder: JSONDecoder) throws -> T {
		guard let code = (response as? HTTPURLResponse)?.statusCode else {
			throw DecodedErrors.network(description: "Invalid URL", data: data)
		}
		guard HTTPCodes.success.contains(code) else {
			throw DecodedErrors.network(description: "Network error: \(code)", data: data)
		}
		return try decoder.decode(T.self, from: data)
	}
}

extension NetworkService {
	static var userAgent: String {
		// let info = Application.shared.osAppVersion
        return "OS:ios OSVERSION:\(17.1) APPVERSION:\(1.1)"
	}
}
