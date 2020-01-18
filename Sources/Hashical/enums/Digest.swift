//
//  Digest.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public typealias DigestFunction = (_ data: UnsafeRawPointer?, _ len: CC_LONG, _ md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>?


public enum Digest {
	
	case sha1
	case sha224
	case sha256
	case sha384
	case sha512
	
	public var length: Int32 {
		
		switch self {
		case .sha1: return CC_SHA1_DIGEST_LENGTH
		case .sha224: return CC_SHA224_DIGEST_LENGTH
		case .sha256: return CC_SHA256_DIGEST_LENGTH
		case .sha384: return CC_SHA384_DIGEST_LENGTH
		case .sha512: return CC_SHA512_DIGEST_LENGTH
		}
		
	}
	
	public var encryptor: DigestFunction {
		
		switch self {
		case .sha1: return CC_SHA1
		case .sha224: return CC_SHA224
		case .sha256: return CC_SHA256
		case .sha384: return CC_SHA384
		case .sha512: return CC_SHA512
		}
		
	}
}
