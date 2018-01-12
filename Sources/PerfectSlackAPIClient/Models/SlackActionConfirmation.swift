//
//  SlackActionConfirmation.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 12.01.18.
//

import ObjectMapper

/// Protect users from destructive actions or particularly distinguished decisions
/// by asking them to confirm their button click one more time. Use confirmation dialogs with care.
public struct SlackActionConfirmation {
    
    /// Title the pop up window. Please be brief.
    var title: String?
    
    /// Describe in detail the consequences of the action and contextualize your button text choices.
    /// Use a maximum of 30 characters or so for best results across form factors.
    var text: String
    
    /// The text label for the button to continue with an action. Keep it short. Defaults to Okay.
    var okText: String?
    
    /// The text label for the button to cancel the action. Keep it short. Defaults to Cancel.
    var dismissText: String?
    
}

// MARK: Mappable

extension SlackActionConfirmation: Mappable {
    
    public init?(map: Map) {
        let json = map.JSON
        guard let text = json["text"] as? String else {
            return nil
        }
        self.text = text
    }
    
    public mutating func mapping(map: Map) {
        self.title <- map["title"]
        self.text <- map["text"]
        self.okText <- map["ok_text"]
        self.dismissText <- map["dismiss_text"]
    }
    
}
