//
//  Data+Key.swift
//  Cryptography
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Black Pixel. All rights reserved.
//

import Foundation
import CommonCrypto

extension Data {
	
	public func keyDerivation(salt:[UInt8], pra:PseudoRandomAlgorithm, keySize:KeySize) ->Data {
		
		let alg = PasswordBasedKeyDerivationAlgorithm.pbkdf2
		let rounds = CCCalibratePBKDF(alg.ccPBDKF, count, salt.count, pra.ccPRF, keySize.size, 1)

		var pbkey = [UInt8](repeating: 0, count: keySize.size)
		withUnsafeBytes { 
			_ = CCKeyDerivationPBKDF(alg.ccPBDKF, $0.bindMemory(to: Int8.self).baseAddress, count, salt, salt.count, pra.ccPRF, rounds, &pbkey, keySize.size)
		}
		
		return Data(pbkey)
		
	}
	
}
