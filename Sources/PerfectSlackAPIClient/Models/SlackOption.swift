//
//  SlackAttachmentActionOption.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 12.01.18.
//

import ObjectMapper

/// An option field. Used in static and external message menu data types.
public struct SlackAttachmentActionOption {
    
    /// A short, user-facing string to label this option to users.
    /// Use a maximum of 30 characters or so for best results across, you guessed it, form factors.
    var text: String
    
    /// A short string that identifies this particular option to your application.
    /// It will be sent to your Action URL when this option is selected.
    /// While there's no limit to the value of your Slack app, this value may contain up to only 2000 characters.
    var value: String
    
    /// A user-facing string that provides more details about this option. Also should contain up to 30 characters.
    var description: String
    
}

// MARK: Mappable

extension SlackAttachmentActionOption: Mappable {
    
    /// ObjectMapper initializer
    public init?(map: Map) {
        let json = map.JSON
        guard let text = json["text"] as? String,
            let value = json["value"] as? String,
            let description = json["description"] as? String else {
            return nil
        }
        self.text = text
        self.value = value
        self.description = description
    }
    
    /// Mapping
    public mutating func mapping(map: Map) {
        self.text           <- map["text"]
        self.value          <- map["value"]
        self.description    <- map["description"]
    }
    
}
