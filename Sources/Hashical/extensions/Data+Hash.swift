//
//  Data+Hash.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
	
	public func digest(_ digest:Digest) ->Data {
		
		var hashed = [UInt8](repeating:0, count:Int(digest.length))
		
		withUnsafeBytes { 
			_ = digest.encryptor($0.baseAddress, CC_LONG(count), &hashed)
		}
		
		return Data(hashed)
	}

}
