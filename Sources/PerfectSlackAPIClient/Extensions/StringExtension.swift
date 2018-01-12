//
//  StringExtension.swift
//  PerfectAPIClient
//
//  Created by Sven Tiigi on 12.01.18.
//

import Foundation

public extension String {
    
    /// String MarkdownFormat Enumeration
    public enum MarkdownFormat {
        /// ```pre```
        case pre
        /// `code`
        case code
        /// _italic_
        case italic
        /// *bold*
        case bold
        /// ~strike~
        case strike
    }
    
    /// Convert the String to a specific Markdown format
    ///
    /// - Parameter format: The Markdown format
    /// - Returns: The updated string in markdown format
    func toMarkdown(format: MarkdownFormat) -> String {
        switch format {
        case .pre:
            return "```\(self)```"
        case .code:
            return "`\(self)`"
        case .italic:
            return "_\(self)_"
        case .bold:
            return "*\(self)*"
        case .strike:
            return "~\(self)~"
        }
    }
    
    /// Escape characters to match the guidelines for a Slack Message
    /// Slack: There are three characters you must convert to HTML entities and only three: &, <, and >.
    mutating func escapeSlackCharacters() {
        self = self.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
    }
    
}
