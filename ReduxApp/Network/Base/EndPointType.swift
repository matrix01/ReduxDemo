//
//  EndPoints.swift
//  Toranoko
//
//  Created by Mia Milan on 2022/02/04.
//  Copyright © 2022 TORANOTEC K.K. All rights reserved.
//
import Foundation
import UIKit

/// HTTPMethodType is the similar representation of HTTPMethod
enum HTTPMethodType: String {
	case GET
	case POST
	case DELETE
	case PUT
}

/// Generic EndPoints for any Network services
/// Idea is to any network service that extends NetworkService should extend EndPointType too
protocol EndPointType {
	var completeURL: URL? { get }

	/// - Parameter host: domain for the api service
	/// Keeping it flex for when the app uses different domains in different module
	/// var host: String { get }

	/// - Parameter path: path for  a specific api
	var path: String { get }

	/// - Parameter method: GET / POST / PATH / DELETE
	var method: HTTPMethodType { get }

	// swiftlint:disable discouraged_optional_collection
	/// - Parameter headers: Headers for URLRequests
	/// Example: ["Accept": "application/json"]
	var headers: [String: String]? { get }

	/// - Parameter params: Query parameters for api
	var params: [URLQueryItem]? { get }

	/// URL request body
	func body() throws -> Data?
}

/// Base setup for Endpoints
/// Any service that needs to create a request can provide
/// implementation for EndPoint and get the request
extension EndPointType {
	var completeURL: URL? {
		var urlComponents = URLComponents()
		urlComponents.host = host
		urlComponents.scheme = scheme
		urlComponents.path = "/" + "\(path)"
		urlComponents.queryItems = params
		return urlComponents.url
	}

	// swiftlint:disable discouraged_optional_collection
	var headers: [String: String]? {
        let languageCode = Locale.current.language.languageCode?.identifier ?? "ja"
        if let sessionToken = Bundle.main.object(forInfoDictionaryKey: "GIT_API_KEY") {
            return [
                "Content-Type": "application/json; charset=utf-8",
                "User-Agent": NetworkService.userAgent,
                "accept-language": languageCode,
                "Authorization": "Bearer \(sessionToken)"
            ]
        } else {
            return [
                "Content-Type": "application/json; charset=utf-8",
                "User-Agent": NetworkService.userAgent,
                "accept-language": languageCode
            ]
        }
	}

	func body() throws -> Data? {
		nil
	}

	private var host: String {
		AppEnvironment.serverURL
	}

	private var scheme: String {
		AppEnvironment.scheme
	}

	static var headerType: String {
		"application/json"
	}

	var request: URLRequest? {
		guard let url = completeURL else {
			return nil
		}

		var newRequest = URLRequest(url: url)
		newRequest.httpMethod = method.rawValue
		newRequest.allHTTPHeaderFields = headers
		newRequest.timeoutInterval = 20_000.0
		return newRequest
	}

	/// URLSession requires a request. This create request for given inputs
	/// - Parameter baseURL: Domain or base path of the API service
	/// - Returns: URLRequest
	func asyncRequest() throws -> URLRequest {
		guard let url = completeURL else {
			throw DecodedErrors.parsing(description: "Failed to parse completeURL")
		}
		var asyncRequest = URLRequest(url: url)
		asyncRequest.httpMethod = method.rawValue
		asyncRequest.allHTTPHeaderFields = headers
		asyncRequest.httpBody = try body()
		asyncRequest.timeoutInterval = 60
		return asyncRequest
	}
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
	static let success = 200 ..< 300
	static let retry = 1_002
}
