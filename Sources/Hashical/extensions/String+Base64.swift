//
//  String+Base64.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation

extension String {
	
	public var base64Encoded: String? { data(using: .utf8, allowLossyConversion:false)?.base64EncodedString() }
	
	public var base64Decoded: String? {
		
		let rem = lengthOfBytes(using: .utf8) % 4
		let padding = rem == 0 ? "" : String(repeating: "=", count: 4-rem)
		
		guard let data = Data(base64Encoded: self+padding) else { return nil }
		return String(data: data, encoding: .utf8)
		
	}
	
}
