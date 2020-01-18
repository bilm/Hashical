//
//  Zip.swift
//  Cryptography
//
//  Created by Bil on 5/12/17.
//  Copyright © 2017 Black Pixel. All rights reserved.
//

import Foundation
import Compression

public enum CompressionConfig {
	
	case encode(CompressionAlgorithm)
	case decode(CompressionAlgorithm)
	
	public var operation: compression_stream_operation {
		
		switch self {
		case .encode: return COMPRESSION_STREAM_ENCODE
		case .decode: return COMPRESSION_STREAM_DECODE
		}
		
	}
	
	public var algorithm: compression_algorithm {
		
		switch self {
		case .encode(let alg): return alg.algorithm
		case .decode(let alg): return alg.algorithm
		}
		
	}
	
}

public enum CompressionAlgorithm {
	
	case ZLIB
	case LZFSE
	case LZMA
	case LZ4
	case LZ4_RAW
	
	var algorithm: compression_algorithm {
		
		switch self {
		case .ZLIB    : return COMPRESSION_ZLIB
		case .LZFSE   : return COMPRESSION_LZFSE
		case .LZMA    : return COMPRESSION_LZMA
		case .LZ4     : return COMPRESSION_LZ4
		case .LZ4_RAW : return COMPRESSION_LZ4_RAW
		}
		
	}

}

public extension Data {
	
	func compress(with algorithm: CompressionAlgorithm) -> Data? {
		
		withUnsafeBytes {
			let p = $0.bindMemory(to: UInt8.self)
			return compress(.encode(algorithm), source: p.baseAddress, size: count)
		}
		
	}
	
	
	func decompress(with algorithm: CompressionAlgorithm) -> Data? {
		
		withUnsafeBytes {
			let p = $0.bindMemory(to: UInt8.self)
			return compress(.decode(algorithm), source: p.baseAddress, size: count)
		}
		
	}
	
	
	func deflate() -> Data? {
		
		withUnsafeBytes {
			let p = $0.bindMemory(to: UInt8.self)
			return compress(.encode(.ZLIB), source: p.baseAddress, size: count)
		}
		
	}
	
	
	func inflate() -> Data? {
		
		withUnsafeBytes {
			let p = $0.bindMemory(to: UInt8.self)
			return compress(.decode(.ZLIB), source: p.baseAddress, size: count)
		}
		
	}
	
	
	func zip() -> Data? {
		
		var res = Data([0x78, 0x5e])
		
		guard let deflated = deflate() else { return nil }
		res.append(deflated)
		
		var checksum = adler.bigEndian
		res.append(Data(bytes: &checksum, count: MemoryLayout<UInt32>.size))
		
		return res
		
	}
	
	
	func unzip(validate: Bool = true) -> Data? {
		
		let extraBytes = 6
		guard count > extraBytes else { return nil }
		
		var header: UInt16 = withUnsafeBytes { $0.load(as: UInt16.self) }
		header = header.bigEndian
		guard header >> 8 & 0x000F == 0x0008 else { return nil }
		guard header % 31 == 0 else { return nil }
		
		guard let inflated = withUnsafeBytes ({ 
			compress(.decode(.ZLIB), source: ($0.bindMemory(to: UInt8.self).baseAddress!)+2, size: count - extraBytes)
		}) else { return nil }
		
		guard validate else { return inflated }
		
		let checksum: UInt32 = withUnsafeBytes {
//			(p:UnsafePointer<UInt8>) in
			let q = ($0.bindMemory(to: UInt8.self).baseAddress!) + (count - 4)
			return q.withMemoryRebound(to: UInt32.self, capacity: 1) { $0.pointee.bigEndian }
		}
		
		return checksum == inflated.adler ? inflated : nil
		
	}
	
	
	var adler: UInt32 {
		
		var a: UInt32 = 1
		var b: UInt32 = 0
		
		for byte in self {
			a += UInt32(byte)
			if a >= 65521 { a = a % 65521 }
			b += a
			if b >= 65521 { b = b % 65521 }
		}
		
		return (b << 16) | a
		
	}
	
	private func compress(_ config: CompressionConfig, source: UnsafePointer<UInt8>!, size: Int) -> Data? {
		
		guard config.operation == COMPRESSION_STREAM_ENCODE || size > 0 else { return nil }
		
		let streamBase = UnsafeMutablePointer<compression_stream>.allocate(capacity: 1)
		defer { streamBase.deallocate() }
		var stream = streamBase.pointee
		
		let status = compression_stream_init(&stream, config.operation, config.algorithm)
		guard status != COMPRESSION_STATUS_ERROR else { return nil }
		defer { compression_stream_destroy(&stream) }
		
		let bufferSize = Swift.max( Swift.min(size, 64 * 1024), 64)
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
		defer { buffer.deallocate() }
		
		stream.dst_ptr  = buffer
		stream.dst_size = bufferSize
		stream.src_ptr  = source
		stream.src_size = size
		
		var res = Data()
		let flags = Int32(COMPRESSION_STREAM_FINALIZE.rawValue)
		
		while true {
			switch compression_stream_process(&stream, flags) {
			case COMPRESSION_STATUS_OK:
				guard stream.dst_size == 0 else { return nil }
				res.append(buffer, count: stream.dst_ptr - buffer)
				stream.dst_ptr = buffer
				stream.dst_size = bufferSize
				
			case COMPRESSION_STATUS_END:
				res.append(buffer, count: stream.dst_ptr - buffer)
				return res
				
			default:
				return nil
			}
		}
	
	}
	
}
