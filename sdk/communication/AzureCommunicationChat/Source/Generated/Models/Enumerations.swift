// --------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator.
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// --------------------------------------------------------------------------

import AzureCore
import Foundation

/// The chat message priority.
public enum ChatMessagePriority: RequestStringConvertible, Codable, Equatable {
    // Custom value for unrecognized enum values
    case custom(String)

    case normal

    case high

    public var requestString: String {
        switch self {
        case let .custom(val):
            return val
        case .normal:
            return "normal"
        case .high:
            return "high"
        }
    }

    public init(_ val: String) {
        switch val.lowercased() {
        case "normal":
            self = .normal
        case "high":
            self = .high
        default:
            self = .custom(val)
        }
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self.init(value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(requestString)
    }
}

/// The chat message type.
public enum ChatMessageType: RequestStringConvertible, Codable, Equatable {
    // Custom value for unrecognized enum values
    case custom(String)

    case text

    case html

    case topicUpdated

    case participantAdded

    case participantRemoved

    public var requestString: String {
        switch self {
        case let .custom(val):
            return val
        case .text:
            return "text"
        case .html:
            return "html"
        case .topicUpdated:
            return "topicUpdated"
        case .participantAdded:
            return "participantAdded"
        case .participantRemoved:
            return "participantRemoved"
        }
    }

    public init(_ val: String) {
        switch val.lowercased() {
        case "text":
            self = .text
        case "html":
            self = .html
        case "topicupdated":
            self = .topicUpdated
        case "participantadded":
            self = .participantAdded
        case "participantremoved":
            self = .participantRemoved
        default:
            self = .custom(val)
        }
    }

    // MARK: Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self.init(value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(requestString)
    }
}