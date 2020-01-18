//
//  Data+String.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation

extension Data {
	
	public var hex:String { map{ String(format: "%02x", $0) }.joined(separator: "") }
	
}


