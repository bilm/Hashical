//
//  Operation.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum CryptOperation {
	
	case encrypt
	case decrypt
	
	public var ccOperation: CCOperation {
		
		switch self {
		case .encrypt: return CCOperation(kCCEncrypt)
		case .decrypt: return CCOperation(kCCDecrypt)
		}
		
	}
	
}

