//
//  Unsigned.swift
//  Miscellany
//
//  Created by Bil on 9/26/17.
//  Copyright © 2017 Lightswitch Ink. All rights reserved.
//

import Foundation

extension UnsignedInteger {
	
	/// Answer self as a HEX string
	var hex: String { String(self, radix:16, uppercase:true) }
	
	/// Answer self as a Data object
	var data: Data {
		
		var this = self
		return Data(bytes:&this, count: MemoryLayout.stride(ofValue: self))
		
	}

}

