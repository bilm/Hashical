//
//  JWT.swift
//  Cryptography
//
//  Created by Bil on 7/29/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation

extension Data {
	
	//
	//	NOTE:	We are the "key" to use to sign the payload
	//
	public func makeJWT(_ payload: [String:Any]) ->String {
		
		let headerJSON = try? JSONSerialization.data(withJSONObject: ["typ": "JWT", "alg":"HS256"], options: [])
		let header64 = headerJSON!.base64EncodedString().urlQuerySafe
		
		let payloadJSON = try? JSONSerialization.data(withJSONObject: payload, options: [])
		let payload64 = payloadJSON!.base64EncodedString().urlQuerySafe
		
		let toBeSigned = "\(header64).\(payload64)"
		
		let hmac:Data = toBeSigned.hs256(self)
		let signed = hmac.base64EncodedString().urlQuerySafe
		
		let token = "\(toBeSigned).\(signed)"
		return token
		
	}
	
}

extension String {
	
	public func unmakeJWT() -> (header: String,payload: String) {
		
		let parts = components(separatedBy: ".")
		let header = parts[0].urlQueryUnsafe.base64Decoded ?? ""
		let payload = parts[1].urlQueryUnsafe.base64Decoded ?? ""
		return (header:header,payload:payload)
		
	}
	
}


extension String {
	
	public var urlQuerySafe: String { 
		
		replacingOccurrences(of: "+", with: "-")
		.replacingOccurrences(of: "/", with: "_")
		.replacingOccurrences(of: "=", with: "")
		
	}
	
	public var urlQueryUnsafe: String { 
		
		replacingOccurrences(of: "-", with: "+")
		.replacingOccurrences(of: "_", with: "/")
		
	}
	
}
