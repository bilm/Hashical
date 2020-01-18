//
//  File.swift
//  
//
//  Created by Bil Moorhead on 1/17/20.
//

import XCTest
@testable import Hashical

final class ZipTests: XCTestCase {
	
	let input = "A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight...A string that really needs to loose some weight..."

	lazy var raw = Data(input.utf8)
	
	let hexes = [
		"7354282e29cacc4b5728c9482c51284a4dccc9a954c84b4d4d295628c957c8c9cf2f4e5528cecf4d55284fcd4ccf28d1d3d3731cd531e2740000",
		"785e7354282e29cacc4b5728c9482c51284a4dccc9a954c84b4d4d295628c957c8c9cf2f4e5528cecf4d55284fcd4ccf28d1d3d3731cd531e2740000803fc525",
		"6276786e2602000046000000e0224120737472696e672074686174207265616c6c79206e6565647320746f206c6f6f736520736f6d65207765696768742e2e2e3832f0fff0c8e32e2e2e060000000000000062767824",
		"6276343126020000aa000000ff234120737472696e672074686174207265616c6c79206e6565647320746f206c6f6f736520736f6d65207765696768742e2e2e3200ff72f0616d65207765696768742e2e2e4120737472696e672074686174207265616c6c79206e6565647320746f206c6f6f736520736f6d65207765696768742e2e2e4120737472696e672074686174207265616c6c79206e6565647320746f206c6f6f736520736f6d65207765696768742e2e2e62763424",
		"fd377a585a000000ff12d9410200210116000000742fe5a3e0022500395d0020880a6743c05fa2bd633931a86d4ca739048bc5239c77b92445fcaa2dd5e89e0fafb003b1781d5f53b9133d0e647a7d549ecc8e07e3a800000000000000014da6040000000e309600a8000afc020000000000595a",
		
	]
	
	func testZip0_deflate() {
		
		//
		//	NOTE - 	uses `ZLIB`
		let data = raw.deflate()
		XCTAssertEqual(data?.count, 58)
		XCTAssertEqual(data?.hex, hexes[0])
		//	END-NOTE
		//

	}
	func testZip0_inflate() {
		
		//
		//	NOTE - 	uses `ZLIB`
		let data = raw.deflate()
		XCTAssertEqual(data?.inflate(), raw)
		//	END-NOTE
		//

	}

	func testZip0_zip() {
		
		//
		//	NOTE - 	uses `ZLIB` with an `adler` checksum
		let data = raw.zip()
		XCTAssertEqual(data?.count, 64)
		XCTAssertEqual(data?.hex, hexes[1])
		//	END-NOTE
		//

	}
	func testZip0_unzip() {
		
		//
		//	NOTE - 	uses `ZLIB` with an `adler` checksum
		let data = raw.zip()
		XCTAssertEqual(data?.unzip(), raw)
		//	END-NOTE
		//

	}

	func testZip0_lzfse() {
		
		let data = raw.compress(with: .LZFSE)
		XCTAssertEqual(data?.count, 86)
		XCTAssertEqual(data?.hex, hexes[2])

	}
	func testZip0_unlzfse() {
		
		let data = raw.compress(with: .LZFSE)
		XCTAssertEqual(data?.decompress(with: .LZFSE), raw)

	}

	func testZip0_lz4() {
		
		let data = raw.compress(with: .LZ4)
		XCTAssertEqual(data?.count, 186)
		XCTAssertEqual(data?.hex, hexes[3])

	}
	func testZip0_unlz4() {
		
		let data = raw.compress(with: .LZ4)
		XCTAssertEqual(data?.decompress(with: .LZ4), raw)

	}

	func testZip0_lz4_raw() {
		
		let data = raw.compress(with: .LZ4_RAW)
		XCTAssertNil(data)

	}
	func testZip0_unlz4_raw() {
		
		let data = raw.compress(with: .LZ4_RAW)
		XCTAssertNil(data)
		XCTAssertNil(data?.decompress(with: .LZ4_RAW))

	}

	func testZip0_lzma() {
		
		let data = raw.compress(with: .LZMA)
		XCTAssertEqual(data?.count, 116)
		XCTAssertEqual(data?.hex, hexes[4])

	}
	func testZip0_unlzma() {
		
		let data = raw.compress(with: .LZMA)
		XCTAssertEqual(data?.decompress(with: .LZMA), raw)

	}

	func testZip0_zlib() {
		
		let data = raw.compress(with: .ZLIB)
		XCTAssertEqual(data?.count, 58)
		XCTAssertEqual(data?.hex, hexes[0])

	}
	func testZip0_unzlib() {
		
		let data = raw.compress(with: .ZLIB)
		XCTAssertEqual(data?.decompress(with: .ZLIB), raw)

	}

	func testZip3() {

		let data = Data(input.utf8)

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
			.inflate() 

		XCTAssertEqual(data, raw)
			
	}
	
}
