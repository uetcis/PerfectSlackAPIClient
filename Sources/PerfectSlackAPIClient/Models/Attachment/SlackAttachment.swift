//
//  SlackAttachment.swift
//  PerfectSlackAPIClient
//
//  Created by Sven Tiigi on 11.01.18.
//

import ObjectMapper

/// Consult the guide to attaching content to messages
/// for more flavor on working with attachments. Attachments house message buttons.
public struct SlackAttachment {
    
    /// Provide this attachment with a visual header by providing a short string here.
    public var title: String?
    
    /// By passing a valid URL in the title_link parameter (optional), the title text will be hyperlinked.
    public var titleLinkURL: String?
    
    /// This is optional text that appears above the message attachment block.
    public var preText: String?
    
    /// This is the main text in a message attachment, and can contain standard message markup.
    /// The content will automatically collapse if it contains 700+ characters or 5+ linebreaks,
    /// and will display a "Show more..." link to expand the content. Links posted in the text field will not unfurl.
    public var text: String?

    /// Small text used to display the author's name.
    public var authorName: String?
    
    /// A valid URL that will hyperlink the author_name text mentioned above.
    /// Will only work if author_name is present.
    public var authorLinkURL: String?
    
    /// A valid URL that displays a small 16x16px image to the left of the author_name text.
    /// Will only work if author_name is present.
    public var authorIconURL: String?
    
    /// A valid URL to an image file that will be displayed inside a message attachment.
    /// We currently support the following formats: GIF, JPEG, PNG, and BMP.
    /// Large images will be resized to a maximum width of 400px or a maximum height of 500px,
    /// while still maintaining the original aspect ratio.
    public var imageURL: String?
    
    /// A valid URL to an image file that will be displayed as a thumbnail
    /// on the right side of a message attachment. We currently support
    /// the following formats: GIF, JPEG, PNG, and BMP.
    /// The thumbnail's longest dimension will be scaled down to 75px
    /// while maintaining the aspect ratio of the image.
    /// The filesize of the image must also be less than 500 KB.
    public var thumbnailURL: String?
    
    /// Used to visually distinguish an attachment from other messages.
    /// Accepts hex values and a few named colors as documented in attaching content to messages.
    /// Use sparingly and according to best practices.
    public var color: Color?
    
    /// A collection of actions (buttons or menus) to include in the attachment.
    /// Required when using message buttons or message menus. A maximum of 5 actions per attachment may be provided.
    public var actions: [Action]?
    
    /// Fields will be displayed in a table inside the message attachment.
    public var fields: [Field]?
    
    /// The provided string will act as a unique identifier for the collection of buttons within the attachment.
    /// It will be sent back to your message button action URL with each invoked action.
    /// This field is required when the attachment contains message buttons.
    /// It is key to identifying the interaction you're working with.
    public var callbackId: String?
    
    /// A plaintext message displayed to users using an interface that does not support attachments or interactive messages.
    /// Consider leaving a URL pointing to your service if the potential message actions are representable outside of Slack.
    /// Otherwise, let folks know what they are missing.
    public var fallback: String?
    
    /// Even for message menus, remains the default value default.
    public var type: AttachmentType?
    
    /// Add some brief text to help contextualize and identify an attachment.
    /// Limited to 300 characters, and may be truncated further when displayed to users
    /// in environments with limited screen real estate.
    public var footer: String?
    
    /// To render a small icon beside your footer text, provide a publicly accessible URL string
    /// in the footer_icon field. You must also provide a footer for the field to be recognized.
    /// We'll render what you provide at 16px by 16px. It's best to use an image that is similarly sized.
    public var footerIconURL: String?
    
    /// Does your attachment relate to something happening at a specific time?
    public var timestamp: Double?
    
    /// Default initializer
    public init() {}
    
}

// MARK: Enums

public extension SlackAttachment {
    
    /// The SlackAttachment Type
    enum AttachmentType: String {
        case `default`
    }
    
    /// Used to visually distinguish an attachment from other messages.
    enum Color {
        /// Good (green)
        case good
        /// Warning (yellow)
        case warning
        /// Danger (red)
        case danger
        /// Custom Hex-Value. Example: #009688
        case custom(hexValue: String)
        
        /// Color EnumTransformType
        struct EnumTransformType: TransformType {
            /// Object Typealias
            typealias Object = Color
            /// JSON Typealias
            typealias JSON = String
            /// JSON to Enum
            func transformFromJSON(_ value: Any?) -> SlackAttachment.Color? {
                // Unwrap optional value as string
                guard let value = value as? String else {
                    // Unwrapping failed return nil
                    return nil
                }
                /// Switch on value
                switch value {
                case "good":
                    return .good
                case "warning":
                    return .warning
                case "danger":
                    return .danger
                default:
                    return .custom(hexValue: value)
                }
            }
            /// Enum to JSON
            func transformToJSON(_ value: SlackAttachment.Color?) -> String? {
                // Unwrap value
                guard let value = value else {
                    // Unwrapping failed return nil
                    return nil
                }
                // Switch on value
                switch value {
                case .good:
                    return "good"
                case .warning:
                    return "warning"
                case .danger:
                    return "danger"
                case .custom(hexValue: let hexValue):
                    return hexValue
                }
            }
        }
    }
    
}


// MARK: Mappable

extension SlackAttachment: Mappable {
    
    /// ObjectMapper initializer
    public init?(map: Map) {}
    
    /// Mapping
    public mutating func mapping(map: Map) {
        self.escapeStringValues()
        self.title          <- map["title"]
        self.titleLinkURL   <- map["title_link"]
        self.preText        <- map["pretext"]
        self.text           <- map["text"]
        self.authorName     <- map["author_name"]
        self.authorLinkURL  <- map["author_link"]
        self.authorIconURL  <- map["author_icon"]
        self.imageURL       <- map["image_url"]
        self.thumbnailURL   <- map["thumb_url"]
        self.color          <- (map["color"], SlackAttachment.Color.EnumTransformType())
        self.actions        <- map["actions"]
        self.fields         <- map["fields"]
        self.callbackId     <- map["callback_id"]
        self.fallback       <- map["fallback"]
        self.type           <- map["attachment_type"]
        self.footer         <- map["footer"]
        self.footerIconURL  <- map["footer_icon"]
        self.timestamp      <- map["ts"]
    }
    
    /// Escape Strings before mapping
    private mutating func escapeStringValues() {
        self.title?.escapeSlackCharacters()
        self.preText?.escapeSlackCharacters()
        self.text?.escapeSlackCharacters()
        self.authorName?.escapeSlackCharacters()
    }
    
}
