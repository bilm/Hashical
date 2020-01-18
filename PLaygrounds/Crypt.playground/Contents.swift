//: Playground - noun: a place where people can play

import UIKit
import Cryptography

var str = "Hello, Common Crypto"

//: Uninteresting Passwords
let pswd = Data("g00dBy33".utf8)
let password = Data("^37yG00d".utf8)
print(0, password.hex)

//: A Public key
let salt:[UInt8] = [1,5,9,17]
let pbkey = password.keyDerivation(salt:salt , pra:.sha256, keySize:.aes256)
print(1, pbkey.hex)
print(2, "7cc292e74538021e2463ad713952d75d1af295bbb7f51f9aeaacf5058d42e0a9")
print()

//: a Plaintext, encrypted and then decrypted
let plaintext = Data("four score and seven years ago, our forefathers".utf8)
print(10, plaintext.hex)
if let encrypted = plaintext.encrypt(key:.aes256(pbkey), algorithm:.aes(.ebcModeWithPadding)) {
	print(11, encrypted.hex)
	if let decrypted = encrypted.decrypt(key:.aes256(pbkey), algorithm:.aes(.ebcModeWithPadding)) {
		print(12, decrypted.hex)
		assert(plaintext == decrypted)
		if let message = String(data:decrypted, encoding: .utf8) {
			print(13, message)
		}
	}
}
print()

//: Plaintext, in a HMAC
let hmac256 = plaintext.hmac(.sha256(pbkey))
print(20, hmac256.hex)
let hmac1 = plaintext.hsSH1(pbkey)
print(21, hmac1.hex)
print()


//: Plaintext, using a Digest
let digest = plaintext.digest(.sha512)
print(30, digest.hex)
let digest2 = plaintext.sha512
print(31, digest2.hex)
assert( digest == digest2 )
let sha1 = plaintext.sha1
print(32, sha1.hex)

sleep(1)
