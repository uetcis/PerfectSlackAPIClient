//
//  SlackAttachmentAction.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 11.01.18.
//

import ObjectMapper

// MARK: SlackAttachment Extension

public extension SlackAttachment {
    
    /// The actions you provide will be rendered as message buttons or menus to users.
    struct Action {
        
        /// Provide a string to give this specific action a name.
        /// The name will be returned to your Action URL along with the message's callback_id when this action is invoked.
        /// Use it to identify this particular response path. If multiple actions share the same name,
        /// only one of them can be in a triggered state.
        public var name: String
        
        /// The user-facing label for the message button or menu representing this action.
        /// Cannot contain markup. Best to keep these short and decisive.
        /// Use a maximum of 30 characters or so for best results across form factors.
        public var text: String
        
        /// Provide button when this action is a message button or provide select when the action is a message menu.
        public var type: ActionType
        
        /// Provide a string identifying this specific action.
        /// It will be sent to your Action URL along with the name and attachment's callback_id.
        /// If providing multiple actions with the same name, value can be strategically used to differentiate intent.
        /// Your value may contain up to 2000 characters.
        public var value: String?
        
        /// If you provide the confirmation fields, your button or menu will pop up a dialog
        /// with your indicated text and choices, giving them one last chance
        /// to avoid a destructive action or other undesired outcome.
        public var confirm: Confirmation?
        
        /// Used only with message buttons, this decorates buttons with extra visual importance,
        /// which is especially useful when providing logical default action or highlighting a destructive activity.
        /// default — Yes, it's the default. Buttons will look simple.
        /// primary — Use this sparingly, when the button represents a key action to accomplish.
        /// You should probably only ever have one primary button within a set.
        /// danger — Use this when the consequence of the button click will result in the destruction of something,
        /// like a piece of data stored on your servers. Use even more sparingly than primary.
        public var style: Style?
        
        /// Used only with message menus. The individual options to appear in this menu,
        /// provided as an array of option fields. Required when data_source is static or otherwise unspecified.
        /// A maximum of 100 options can be provided in each menu.
        public var options: [Option]?
        
        /// Used only with message menus. An alternate, semi-hierarchal way to list available options.
        /// Provide an array of option group definitions. This replaces and supersedes the options array.
        public var optionGroups: [Option]?
        
        /// Accepts static, users, channels, conversations, or external.
        /// Our clever default behavior is default, which means the menu's options are
        /// provided directly in the posted message under options. Defaults to static.
        public var dataSource: DataSource?
        
        /// If provided, the first element of this array will be set as the pre-selected option for this menu.
        // Any additional elements will be ignored.
        /// The selected option's value field is contextual based on menu type and is always required:
        /// For menus of type static (the default) this should be in the list of options included in the action.
        /// For menus of type users, channels, or conversations, this should be a valid ID of the corresponding type.
        /// For menus of type external this can be any value, up to a couple thousand characters.
        public var selectedOptions: [Option]?
        
        /// Only applies when data_source is set to external. If present, Slack will wait till the specified
        /// number of characters are entered before sending a request to your app's external
        /// suggestions API endpoint. Defaults to 1.
        public var minQueryLength: Int?
        
        /// Default initializer
        ///
        /// - Parameters:
        ///   - name: The name
        ///   - text: The text
        ///   - type: The type
        public init(name: String, text: String, type: ActionType) {
            self.name = name
            self.text = text
            self.type = type
        }
        
    }
    
}

// MARK: Enums

public extension SlackAttachment.Action {
    
    /// SlackAttachmentAction.ActionType
    enum ActionType: String {
        /// Button
        case button
        /// Selection
        case select
    }
    
    /// SlackAttachmentAction.Style
    enum Style: String {
        /// Default
        case `default`
        /// Primary Style
        case primary
        /// Danger (Red)
        case danger
    }
    
    /// SlackAttachmentAction.DataSource
    enum DataSource: String {
        /// Default
        case `default`
        /// Static
        case `static`
        /// Users
        case users
        /// Channels
        case channels
        /// Conversation
        case conversation
        /// External
        case external
    }
    
}

// MARK: Mappable

extension SlackAttachment.Action: Mappable {
    
    /// ObjectMapper initializer
    public init?(map: Map) {
        let json = map.JSON
        guard let name = json["name"] as? String,
            let text = json["text"] as? String,
            let typeString = json["type"] as? String,
            let type = ActionType(rawValue: typeString) else {
            return nil
        }
        self.name = name
        self.text = text
        self.type = type
    }
    
    /// Mapping
    public mutating func mapping(map: Map) {
        self.escapeStringValues()
        self.name               <- map["name"]
        self.text               <- map["text"]
        self.type               <- map["type"]
        self.value              <- map["value"]
        self.confirm            <- map["confirm"]
        self.style              <- map["style"]
        self.options            <- map["options"]
        self.optionGroups       <- map["optionGroups"]
        self.dataSource         <- map["dataSource"]
        self.selectedOptions    <- map["selectedOptions"]
        self.minQueryLength     <- map["minQueryLength"]
    }
    
    /// Escape Strings before mapping
    private mutating func escapeStringValues() {
        self.name.escapeSlackCharacters()
        self.text.escapeSlackCharacters()
        self.value?.escapeSlackCharacters()
    }
   
}
