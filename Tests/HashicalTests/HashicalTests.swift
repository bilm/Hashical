import XCTest
@testable import Hashical

final class HashicalTests: XCTestCase {

	let pswd = Data("g00dBy33".utf8)
	let password = Data("^37yG00d".utf8)
	let plaintext = Data("four score and seven years ago, our forefathers".utf8)
	
	let salt:[UInt8] = [1,5,9,17]
	lazy var pbkey = password.keyDerivation(salt:salt , pra:.sha256, keySize:.aes256)
	
	let hexes = [
		"7cc292e74538021e2463ad713952d75d1af295bbb7f51f9aeaacf5058d42e0a9",
		"bf1cac9b0ba11f6e68dac30c30d95815ffca847ef9c865392b10ec9022f3910dddedd712455742c3304206c7e444b59d",
		"c67f5c3840dd4c6a0697e0b4cd726c480b2eb383",
		"bb86ab80eb6b58dfbdd3d10b623e08d2dfdbb87089f7528e7eb7ad1800110f91",
		"c1158249b69bc52b75cadb91be76b4a7e919f7498838a3bf09a2da15a33b64f54c006a36785b615f5cc1a22b4b17591f6aa031958062b86090b496069b8dce02",
	]
	
	func testPublicKey() {
		
		let pbkey = password.keyDerivation(salt:salt , pra:.sha256, keySize:.aes256)
		
		XCTAssertEqual(pbkey.hex, hexes[0])

	}
	
	func testPlaintext() {
		
		let key: Key = .aes256(pbkey)
		let algorithm: Algorithm = .aes(.ebcModeWithPadding)
		
		guard let encrypted = plaintext.encrypt(key:key, algorithm:algorithm) else {
			XCTFail("Cannot encrypt")
			return
		}
		XCTAssertEqual(encrypted.hex, hexes[1])

		guard let decrypted = encrypted.decrypt(key:key, algorithm:algorithm) else {
			XCTFail("Cannot decrypt")
			return			
		}
		String(data:decrypted, encoding: .utf8).flatMap { print($0) }
		XCTAssertEqual(decrypted, plaintext)

	}

	func testSH1 () {
		
		let sha1 = plaintext.sha1
		XCTAssertEqual(sha1.hex, hexes[2])

	}
		
	func testHMAC() {
		
		let hmac = plaintext.hmac(.sha256(pbkey))
		XCTAssertEqual(hmac.hex, hexes[3])
		
		let hmac2 = plaintext.hs256(pbkey)
		XCTAssertEqual(hmac2.hex, hexes[3])

		XCTAssertEqual(hmac, hmac2)
	}
	
	func testDigest() {
		
		let digest = plaintext.digest(.sha512)
		XCTAssertEqual(digest.hex, hexes[4])
		
		let digest2 = plaintext.sha512
		XCTAssertEqual(digest2.hex, hexes[4])
		
		XCTAssertEqual(digest, digest2)

	}
	
}
