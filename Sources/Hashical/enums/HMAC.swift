//
//  HMAC.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum HMAC {
	
	case md5(Data)
	case sha1(Data)
	case sha224(Data)
	case sha256(Data)
	case sha384(Data)
	case sha512(Data)
	
	public var key:Data {
		
		switch self {
		case .md5(let d): return d
		case .sha1(let d): return d
		case .sha224(let d): return d
		case .sha256(let d): return d
		case .sha384(let d): return d
		case .sha512(let d): return d
		}
		
	}
	
	public var length:Int32 {
		
		switch self {
		case .md5: return CC_MD5_DIGEST_LENGTH
		case .sha1: return CC_SHA1_DIGEST_LENGTH
		case .sha224: return CC_SHA224_DIGEST_LENGTH
		case .sha256: return CC_SHA256_DIGEST_LENGTH
		case .sha384: return CC_SHA384_DIGEST_LENGTH
		case .sha512: return CC_SHA512_DIGEST_LENGTH
		}
		
	}
	
	public var algorithm:CCHmacAlgorithm {
		switch self {
		case .md5: return CCHmacAlgorithm(kCCHmacAlgMD5)
		case .sha1: return CCHmacAlgorithm(kCCHmacAlgSHA1)
		case .sha224: return CCHmacAlgorithm(kCCHmacAlgSHA224)
		case .sha256: return CCHmacAlgorithm(kCCHmacAlgSHA256)
		case .sha384: return CCHmacAlgorithm(kCCHmacAlgSHA384)
		case .sha512: return CCHmacAlgorithm(kCCHmacAlgSHA512)
		}	
		
	}
	
}
