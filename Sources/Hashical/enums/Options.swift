//
//  Options.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum Options {
	
	case cbcMode
	case ecbMode
	case pkcs7Padding
	case ebcModeWithPadding
	
	public var ccOptions: CCOptions {
		
		switch self {
		case .cbcMode: return CCOptions(0)
		case .ecbMode: return CCOptions(kCCOptionECBMode)
		case .pkcs7Padding: return CCOptions(kCCOptionPKCS7Padding)
		case .ebcModeWithPadding: return CCOptions(kCCOptionECBMode + kCCOptionPKCS7Padding)
		}
		
	}
	
}
