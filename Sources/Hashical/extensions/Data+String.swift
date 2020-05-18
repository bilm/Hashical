//
//  Data+String.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation

extension Data {
	
	public var hex: String { 
		
		map{ String(format: "%02x", $0) }
		.joined(separator: "")
		
	}
	
	public init(hexString: String) {
		
		self.init()
		
		hexString
			.chunks(of: 2)
			.lazy
			.forEach { append( UInt8( $0, radix: 16)! ) }
		
	}
	
}

extension StringProtocol {
	
	public func chunks(of n: Int) ->[SubSequence] {
		
		var chunks: [SubSequence] = []
		var idx = startIndex
		while let nxt = index(idx, offsetBy: n, limitedBy: endIndex) {
			
			chunks.append( self[idx..<nxt] )
			idx = nxt
			
		}
		return chunks
		
	}

}
