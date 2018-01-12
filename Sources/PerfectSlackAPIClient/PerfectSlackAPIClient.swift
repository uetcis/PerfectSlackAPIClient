//
//  PerfectSlackAPIClient.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 11.01.18.
//

import PerfectAPIClient
import PerfectHTTP
import PerfectCURL
import ObjectMapper

/// Slack API Client
public enum PerfectSlackAPIClient {
    /// Send a SlackMessage
    case send(SlackMessage)
}

// MARK: Configuration

public extension PerfectSlackAPIClient {
    
    /// The PerfectSlackAPIClient Configurations
    struct Configuration {
        /// The Slack Webhook URL. Default value: String()
        static var webhookURL = String()
        /// Logging Configuration. Default value: false
        static var logging = false
        /// The Slack Message Builder URL
        static var messageBuilderURL = "https://api.slack.com/docs/messages/builder?msg="
    }
    
}

// MARK: APIClient

extension PerfectSlackAPIClient: APIClient {
    
    /// The base url
    public var baseURL: String {
        switch self {
        case .send:
            if (PerfectSlackAPIClient.Configuration.webhookURL.isEmpty) {
                print("[PerfectSlackAPIClient Warning]: No webhook url specified. Please set a webhook url")
            }
            return PerfectSlackAPIClient.Configuration.webhookURL
        }
    }
    
    /// The path to a specific endpoint
    public var path: String {
        switch self {
        case .send:
            return ""
        }
    }
    
    /// The HTTP method
    public var method: HTTPMethod {
        switch self {
        case .send:
            return .post
        }
    }
    
    /// The HTTP headers
    public var headers: [HTTPRequestHeader.Name : String]? {
        switch self {
        case .send:
            return nil
        }
    }
    
    /// The request payload as BaseMappable
    public var requestPayload: BaseMappable? {
        switch self {
        case .send(message: let message):
            return message
        }
    }
    
    /// The additional request options
    public var options: [CURLRequest.Option]? {
        switch self {
        case .send:
            return [.timeout(10)]
        }
    }
    
    /// The mock response result for unit testing
    public var mockResponseResult: APIClientResult<APIClientResponse>? {
        return nil
    }
    
    /// Will perform request to API endpoint
    ///
    /// - Parameters:
    ///   - request: The APIClientRequest
    public func willPerformRequest(request: APIClientRequest) {
        // Check if logging is enabled
        if (PerfectSlackAPIClient.Configuration.logging) {
            print("PerfectSlackAPIClient will perform request: \(request)")
        }
    }
    
    /// Did retrieve response after request has initiated
    ///
    /// - Parameters:
    ///   - request: The APIClientRequest
    ///   - result: The APIClientResult
    public func didRetrieveResponse(request: APIClientRequest, result: APIClientResult<APIClientResponse>) {
        // Check if logging is enabled
        if (PerfectSlackAPIClient.Configuration.logging) {
            print("PerfectSlackAPIClient did retrieve response with result: \(result) for request: \(request)")
        }
    }
    
}
