//
//  SlackAttachmentField.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 12.01.18.
//

import ObjectMapper

// MAKR: SlackAttachment Extension

public extension SlackAttachment {
    
    /// Fields will be displayed in a table inside the message attachment.
    struct Field {
        
        /// Shown as a bold heading above the value text.
        /// It cannot contain markup and will be escaped for you.
        public var title: String?
        
        /// The text value of the field. It may contain standard message markup
        /// and must be escaped as normal. May be multi-line.
        public var value: String?
        
        /// An optional flag indicating whether the value is short enough
        /// to be displayed side-by-side with other values.
        public var short: Bool?
        
    }
    
}

// MARK: Mappable

extension SlackAttachment.Field: Mappable {
    
    /// ObjectMapper initializer
    public init?(map: Map) {}
    
    /// Mapping
    public mutating func mapping(map: Map) {
        self.escapeStringValues()
        self.title <- map["title"]
        self.value <- map["value"]
        self.short <- map["short"]
    }
    
    /// Escape Strings before mapping
    private mutating func escapeStringValues() {
        self.title?.escapeSlackCharacters()
        self.value?.escapeSlackCharacters()
    }
    
}
