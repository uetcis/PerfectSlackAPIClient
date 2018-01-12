//
//  StringExtension.swift
//  PerfectAPIClient
//
//  Created by Sven Tiigi on 12.01.18.
//

import Foundation

public extension String {
    
    public enum MarkdownFormat {
        case pre
        case code
        case italic
        case bold
        case strike
    }
    
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
    
}
