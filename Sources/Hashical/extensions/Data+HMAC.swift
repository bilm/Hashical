//
//  Data+HMAC.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
	
	public func hmac(_ hmac:HMAC ) ->Data {
		
		var hashed = [UInt8](repeating: 0, count: Int(hmac.length))
		
		hmac.key.withUnsafeBytes { 
			keyBytes in
			withUnsafeBytes { 
				CCHmac(hmac.algorithm, keyBytes.baseAddress, hmac.key.count, $0.baseAddress, count, &hashed)
			}
		}
		
		return Data(hashed)
		
	}
	
}
