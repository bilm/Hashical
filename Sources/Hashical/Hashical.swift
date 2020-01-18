//
//  Hashical.swift
//  Hashical
//
//  Created by Bil on 7/15/16.
//  Copyright © 2016 Lightswitch Ink. All rights reserved.
//

import Foundation
import CommonCrypto

public protocol Hashical: Hashable {
	
	var sha1:   Data { get }
	var sha224: Data { get }
	var sha256: Data { get }
	var sha384: Data { get }
	var sha512: Data { get }
	
	func hsMD5(_ key: Data) ->Data
	func hsSH1(_ key: Data) ->Data
	func hs224(_ key: Data) ->Data
	func hs256(_ key: Data) ->Data
	func hs384(_ key: Data) ->Data
	func hs512(_ key: Data) ->Data
	
}

extension Data: Hashical {
	
	public var sha1: Data   { digest(.sha1) }
	public var sha224: Data { digest(.sha224) }
	public var sha256: Data { digest(.sha256) }
	public var sha384: Data { digest(.sha384) }
	public var sha512: Data { digest(.sha512) }
	
	public func hsMD5(_ key: Data) ->Data { hmac(.md5(key)) }
	public func hsSH1(_ key: Data) ->Data { hmac(.sha1(key)) }
	public func hs224(_ key: Data) ->Data { hmac(.sha224(key)) }
	public func hs256(_ key: Data) ->Data { hmac(.sha256(key)) }
	public func hs384(_ key: Data) ->Data { hmac(.sha384(key)) }
	public func hs512(_ key: Data) ->Data { hmac(.sha512(key)) }
	
}

extension String: Hashical {

	public var sha1: Data   { Data( self.utf8 ).sha1 }
	public var sha224: Data { Data( self.utf8 ).sha224 }
	public var sha256: Data { Data( self.utf8 ).sha256 }
	public var sha384: Data { Data( self.utf8 ).sha384 }
	public var sha512: Data { Data( self.utf8 ).sha512 }
	
	public func hsMD5(_ key: Data) ->Data { Data( self.utf8 ).hsMD5(key) }
	public func hsSH1(_ key: Data) ->Data { Data( self.utf8 ).hsSH1(key) }
	public func hs224(_ key: Data) ->Data { Data( self.utf8 ).hs224(key) }
	public func hs256(_ key: Data) ->Data { Data( self.utf8 ).hs256(key) }
	public func hs384(_ key: Data) ->Data { Data( self.utf8 ).hs384(key) }
	public func hs512(_ key: Data) ->Data { Data( self.utf8 ).hs512(key) }
	
}

extension URL: Hashical {
	
	public var sha1: Data   { absoluteString.sha1   }
	public var sha224: Data { absoluteString.sha224 }
	public var sha256: Data { absoluteString.sha256 }
	public var sha384: Data { absoluteString.sha384 }
	public var sha512: Data { absoluteString.sha512 }
	
	public func hsMD5(_ key: Data) ->Data { absoluteString.hsMD5(key) }
	public func hsSH1(_ key: Data) ->Data { absoluteString.hsSH1(key) }
	public func hs224(_ key: Data) ->Data { absoluteString.hs224(key) }
	public func hs256(_ key: Data) ->Data { absoluteString.hs256(key) }
	public func hs384(_ key: Data) ->Data { absoluteString.hs384(key) }
	public func hs512(_ key: Data) ->Data { absoluteString.hs512(key) }
	
}
