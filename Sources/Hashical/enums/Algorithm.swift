//
//  Algorithm.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

public enum Algorithm {
	
	case aes128(Options)
	case aes(Options)
	case des(Options)
	case des3(Options)
	case cast(Options)
	case rc4(Options)
	case rc2(Options)
	case blowfish(Options)
	
	public var ccAlgorithm: CCAlgorithm {
		
		switch self {
		case .aes128,.aes: return CCAlgorithm(kCCAlgorithmAES)
		case .des: return CCAlgorithm(kCCAlgorithmDES)
		case .des3: return CCAlgorithm(kCCAlgorithm3DES)
		case .cast: return CCAlgorithm(kCCAlgorithmCAST)
		case .rc4: return CCAlgorithm(kCCAlgorithmRC4)
		case .rc2: return CCAlgorithm(kCCAlgorithmRC2)
		case .blowfish: return CCAlgorithm(kCCAlgorithmBlowfish)
		}
		
	}
	
	public var ccBlockSize: Int {
		
		switch self {
		case .aes128,.aes: return kCCBlockSizeAES128
		case .des: return kCCBlockSizeDES
		case .des3: return kCCBlockSize3DES
		case .cast: return kCCBlockSizeCAST
		case .rc4: return 0
		case .rc2: return kCCBlockSizeRC2
		case .blowfish: return kCCBlockSizeBlowfish
		}
		
	}
	
	public var ccOptions: CCOptions {
		
		switch self {
		case .aes128(let opts), .aes(let opts): return opts.ccOptions
		case .des(let opts): return opts.ccOptions
		case .des3(let opts): return opts.ccOptions
		case .cast(let opts): return opts.ccOptions
		case .rc4(let opts): return opts.ccOptions
		case .rc2(let opts): return opts.ccOptions
		case .blowfish(let opts): return opts.ccOptions
		}
		
	}
	
}
