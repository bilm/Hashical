//
//  Key.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum KeySize {
	
	case aes128
	case aes192
	case aes256
	case des
	case des3
	case cast(Int)
	case rc4(Int)
	case rc2(Int)
	case blowfish(Int)

	public var size: Int {
		
		switch self {
		case .aes128: return kCCKeySizeAES128
		case .aes192: return kCCKeySizeAES192
		case .aes256: return kCCKeySizeAES256
		case .des: return kCCKeySizeDES
		case .des3: return kCCKeySize3DES
		case .cast(let proposed): return min(max(proposed,kCCKeySizeMinCAST),kCCKeySizeMaxCAST)
		case .rc4(let proposed): return min(max(proposed,kCCKeySizeMinRC4),kCCKeySizeMaxRC4)
		case .rc2(let proposed): return min(max(proposed,kCCKeySizeMinRC2),kCCKeySizeMaxRC2)
		case .blowfish(let proposed): return min(max(proposed,kCCKeySizeMinBlowfish),kCCKeySizeMaxBlowfish)
		}
		
	}
	
}

public enum Key {
	
	case aes128(Data)
	case aes192(Data)
	case aes256(Data)
	case des(Data)
	case des3(Data)
	case cast(Data)
	case rc4(Data)
	case rc2(Data)
	case blowfish(Data)
	
	public var data: Data {
		
		switch self {
		case .aes128(let data): return data
		case .aes192(let data): return data
		case .aes256(let data): return data
		case .des(let data): return data
		case .des3(let data): return data
		case .cast(let data): return data
		case .rc4(let data): return data
		case .rc2(let data): return data
		case .blowfish(let data): return data
		}
		
	}
	
	public var size: Int {
		
		switch self {
		case .aes128: return KeySize.aes128.size
		case .aes192: return KeySize.aes192.size
		case .aes256: return KeySize.aes256.size
		case .des: return KeySize.des.size
		case .des3: return KeySize.des3.size
		case .cast: return KeySize.cast(data.count).size
		case .rc4: return KeySize.rc4(data.count).size
		case .rc2: return KeySize.rc2(data.count).size
		case .blowfish: return KeySize.blowfish(data.count).size
		}
		
	}
	
	public var isValid:Bool { data.count == size }
}

public enum PasswordBasedKeyDerivationAlgorithm {
	
	case pbkdf2
	
	public var ccPBDKF: CCPBKDFAlgorithm {
		
		switch self {
		case .pbkdf2:   return CCPBKDFAlgorithm(kCCPBKDF2)
		}
		
	}
	
}

