//
//  MerkleHash.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation
import CryptoSwift

struct MerkleHash {
    private let data: Array<UInt8>
    var hexString: String {
        let sha3 = SHA3(variant: .sha256)
        let digest = sha3.calculate(for: data)
        let hexString = digest.reduce("") { $0 + String(format: "%02x", $1) }
        return hexString
    }
    
    init(data: Array<UInt8>) { self.data = data }
    init(dataString: String) { data = dataString.bytes }
}
