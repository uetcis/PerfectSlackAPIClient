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
    case send(message: SlackMessage)
}

// MARK: Configuration

public extension PerfectSlackAPIClient {
    
    struct Configuration {
        /// The Slack Webhook URL
        static var webhookURL = String()
    }
    
}

// MARK: APIClient

extension PerfectSlackAPIClient: APIClient {
    
    public var baseURL: String {
        return PerfectSlackAPIClient.Configuration.webhookURL
    }
    
    public var path: String {
        switch self {
        case .send:
            return ""
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .send:
            return .post
        }
    }
    
    public var headers: [HTTPRequestHeader.Name : String]? {
        switch self {
        case .send:
            return nil
        }
    }
    
    public var requestPayload: BaseMappable? {
        switch self {
        case .send(message: let message):
            return message
        }
    }
    
    public var options: [CURLRequest.Option]? {
        switch self {
        case .send:
            return [.timeout(10)]
        }
    }
    
    public var mockResponseResult: APIClientResult<APIClientResponse>? {
        return nil
    }
    
}

