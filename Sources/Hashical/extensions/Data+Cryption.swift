//
//  Data+Cryption.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
	
	public func encrypt(key: Key, algorithm: Algorithm) ->Data? { crypt(.encrypt, key: key, algorithm: algorithm) }
	public func decrypt(key:Key, algorithm:Algorithm) ->Data? { crypt(.decrypt, key: key, algorithm: algorithm) }
	
	//
	//
	//
	
	public func crypt(_ operation: CryptOperation, key :Key, algorithm: Algorithm) ->Data? {
		
		guard key.isValid else { return nil }
		
		return withUnsafeBytes {
			
			bytes ->Data? in
			let initiation = [UInt8](repeating:0, count:algorithm.ccBlockSize)
			var crypted = [UInt8]()
			var moved:Int = 0
			let status = key.data.withUnsafeBytes { 
				keyBytes ->CCCryptorStatus in
				func doit(_ buffer: inout [UInt8]) ->CCCryptorStatus {
					CCCrypt(
						operation.ccOperation, 
						algorithm.ccAlgorithm, 
						algorithm.ccOptions, 
						keyBytes.baseAddress, key.size, 
						initiation, 
						bytes.baseAddress, count, 
						&buffer, buffer.count, 
						&moved
					)
				}
				
				let ret = doit(&crypted)  
				guard ret == .bufferTooSmall else { return ret }
				
				crypted = [UInt8](repeating: 0, count: moved)
				return doit(&crypted)
			}
			
			guard status == .success else { return nil }
			return Data(crypted[0..<moved])
			
		}
		
	}
	
}

