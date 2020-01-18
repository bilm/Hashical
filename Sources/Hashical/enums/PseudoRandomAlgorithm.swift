//
//  PseudoRandomAlgorithm.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum PseudoRandomAlgorithm {
	
	case sha1
	case sha224
	case sha256
	case sha384
	case sha512
	
	public var ccPRF: CCPseudoRandomAlgorithm {
		
		switch self {
		case .sha1:   return CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1)
		case .sha224: return CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA224)
		case .sha256: return CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256)
		case .sha384: return CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA384)
		case .sha512: return CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA512)
		}
		
	}
	
}
