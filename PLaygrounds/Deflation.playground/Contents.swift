//: Playground - noun: a place where people can play

import UIKit
import Cryptography

var greeting = "Hello, Compression"

let input = "A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight..."

var res: Data? = Data(input.utf8)

res = res?.deflate()
res = res?.inflate()

res = res?.zip()
res = res?.unzip()

res = res?.compress(with: .LZFSE)
res = res?.decompress(with: .LZFSE)

res = res?.compress(with: .LZ4)
res = res?.decompress(with: .LZ4)

res = res?.compress(with: .LZMA)
res = res?.decompress(with: .LZMA)

res = res?.compress(with: .ZLIB)
res = res?.decompress(with: .ZLIB)

if let data = res {
	let output = String(data: data, encoding: .utf8)
	assert(input == output)
}


if let data = Data(input.utf8)
	.deflate()?
	.inflate()?
	.zip()?
	.unzip()?
	.compress(with: .LZFSE)?
	.decompress(with: .LZFSE)?
	.compress(with: .LZ4)?
	.decompress(with: .LZ4)?
	.compress(with: .LZMA)?
	.decompress(with: .LZMA)?
	.compress(with: .ZLIB)?
	.decompress(with: .ZLIB) {
	
	let output = String(data: data, encoding: .utf8)
	assert(input == output)

}

if let data = Data(input.utf8)
	.deflate()?
	.zip()?
	.compress(with: .LZFSE)?
	.compress(with: .LZ4)?
	.compress(with: .LZMA)?
	.compress(with: .ZLIB)?
	.decompress(with: .ZLIB)?
	.decompress(with: .LZMA)?
	.decompress(with: .LZ4)?
	.decompress(with: .LZFSE)?
	.unzip()?
	.inflate() {

	let output = String(data: data, encoding: .utf8)
	assert(input == output)
	
}

res = Data(input.utf8)

res = res?.deflate()
res = res?.zip()
res = res?.compress(with: .LZFSE)
res = res?.compress(with: .LZ4)
res = res?.compress(with: .LZMA)
res = res?.compress(with: .ZLIB)
res = res?.decompress(with: .ZLIB)
res = res?.decompress(with: .LZMA)
res = res?.decompress(with: .LZ4)
res = res?.decompress(with: .LZFSE)
res = res?.unzip()
res = res?.inflate()
