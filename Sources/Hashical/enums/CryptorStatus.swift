//
//  CryptorStatus.swift
//  Cryptography
//
//  Created by Bil on 11/14/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum CryptorStatus:Error {
	
	case success
	case paramError
	case bufferTooSmall
	case memoryFailure
	case alignmentError
	case decodeError
	case unimplemented
	case overflow
	case rngFailure
	case unspecifiedError
	case callSequenceError
	
	public var ccStatus:CCCryptorStatus {
		
		switch self {
		case .success: return CCCryptorStatus(kCCSuccess)
		case .paramError: return CCCryptorStatus(kCCParamError)
		case .bufferTooSmall: return CCCryptorStatus(kCCBufferTooSmall)
		case .memoryFailure: return CCCryptorStatus(kCCMemoryFailure)
		case .alignmentError: return CCCryptorStatus(kCCAlignmentError)
		case .decodeError: return CCCryptorStatus(kCCDecodeError)
		case .unimplemented: return CCCryptorStatus(kCCUnimplemented)
		case .overflow: return CCCryptorStatus(kCCOverflow)
		case .rngFailure: return CCCryptorStatus(kCCRNGFailure)
		case .unspecifiedError: return CCCryptorStatus(kCCUnspecifiedError)
		case .callSequenceError: return CCCryptorStatus(kCCCallSequenceError)
		}
		
	}
	
	public func isStatus(status:CCCryptorStatus) ->Bool { ccStatus == status }

	public static func ==(lhs:CCCryptorStatus, rhs:CryptorStatus) ->Bool { lhs == rhs.ccStatus }
	public static func ==(lhs:CryptorStatus, rhs:CCCryptorStatus) ->Bool { lhs.ccStatus == rhs }
}

