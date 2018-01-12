//
//  SlackAttachmentActionConfirmation.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 12.01.18.
//

import ObjectMapper

// MARK: SlackAttachment.Action Extension

public extension SlackAttachment.Action {
    
    /// Protect users from destructive actions or particularly distinguished decisions
    /// by asking them to confirm their button click one more time. Use confirmation dialogs with care.
    struct Confirmation {
        
        /// Title the pop up window. Please be brief.
        public var title: String?
        
        /// Describe in detail the consequences of the action and contextualize your button text choices.
        /// Use a maximum of 30 characters or so for best results across form factors.
        public var text: String
        
        /// The text label for the button to continue with an action. Keep it short. Defaults to Okay.
        public var okText: String?
        
        /// The text label for the button to cancel the action. Keep it short. Defaults to Cancel.
        public var dismissText: String?
        
    }
    
}

// MARK: Mappable

extension SlackAttachment.Action.Confirmation: Mappable {
    
    /// ObjectMapper initializer
    public init?(map: Map) {
        let json = map.JSON
        guard let text = json["text"] as? String else {
            return nil
        }
        self.text = text
    }
    
    /// Mapping
    public mutating func mapping(map: Map) {
        self.escapeStringValues()
        self.title          <- map["title"]
        self.text           <- map["text"]
        self.okText         <- map["ok_text"]
        self.dismissText    <- map["dismiss_text"]
    }
    
    /// Escape Strings before mapping
    private mutating func escapeStringValues() {
        self.title?.escapeSlackCharacters()
        self.text.escapeSlackCharacters()
        self.okText?.escapeSlackCharacters()
        self.dismissText?.escapeSlackCharacters()
    }
    
}

