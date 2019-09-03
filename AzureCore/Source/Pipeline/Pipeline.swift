//
//  Pipeline.swift
//  AzureCore
//
//  Created by Travis Prescott on 8/29/19.
//  Copyright © 2019 Azure SDK Team. All rights reserved.
//

import Foundation

internal class SansIOHttpPolicyRunner: HttpPolicy {
    
    var next: PipelineSendable?
    let policy: SansIOHttpPolicy
    
    init(policy: SansIOHttpPolicy) {
        self.policy = policy
    }
    
    func send(request: PipelineRequest) throws -> PipelineResponse {
        var response: PipelineResponse
        self.policy.onRequest?(request)
        do {
            response = try self.next!.send(request: request)
            self.policy.onResponse?(response, request: request)
            return response
        } catch {
            if !(self.policy.onError?(request: request) ?? false) {
                throw error
            }
        }
        return PipelineResponse(request: request.httpRequest, response: HttpResponse(request: request.httpRequest, internalResponse: nil), context: request.context)
    }
}

internal class TransportRunner {
    
    var next: PipelineSendable?
    let sender: HttpTransport
    
    init(sender: HttpTransport) {
        self.sender = sender
    }
    
    func send(request: PipelineRequest) throws -> PipelineResponse {
        return PipelineResponse(
            request: request.httpRequest,
            response: try self.sender.send(request: request).httpResponse,
            context: request.context
        )
    }
}

@objc public class Pipeline: NSObject {
    
    private var implPolicies: [AnyObject]
    private let transport: HttpTransport
    
    @objc public init(transport: HttpTransport, policies: [AnyObject] = [AnyObject]()) {
        self.transport = transport
        self.implPolicies = [PipelineSendable]()
        
        for policy in policies {
            if let policy = policy as? SansIOHttpPolicy {
                self.implPolicies.append(SansIOHttpPolicyRunner(policy: policy))
            } else if let policy = policy as? HttpPolicy {
                self.implPolicies.append(policy)
            }
        }
    }
    
    @objc public func run(request: HttpRequest) throws -> PipelineResponse {
        let pipelineRequest = PipelineRequest(request: request)
        let firstNode = self.implPolicies.first ?? TransportRunner(sender: self.transport)
        return try firstNode.send(request: pipelineRequest)
    }
}
