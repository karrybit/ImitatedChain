//
//  ProofOfWork.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation
import CryptoSwift

struct ProofOfWork {
    // TODO: targetの計算
    private static let target = "0001000000111111111111111111111111111111111111111111111111111111"
    
    static func exec() -> (hash: String, nonce: Int, timeStamp: Date) {
        var hash = ""
        var nonce = 0
        var timeStamp = Date()
        
        while true {
            hash = calcHash(nonce: nonce, timeStamp: timeStamp)
            if target > hash { break }
            nonce += 1
            timeStamp = Date()
        }
        
        return (hash, nonce, timeStamp)
    }
    
    static func calcHash(nonce: Int, timeStamp: Date) -> String {
        let rawData: String = BlockChain.shared.latestBlock.header.hash + merkleRoot + String(nonce) + String(Int(timeStamp.timeIntervalSince1970))
        let sha3 = SHA3(variant: .sha512)
        let digest = sha3.calculate(for: rawData.bytes)
        let blockHash = "0x" + digest.reduce("") { $0 + String(format: "%02x", $1) }
        return blockHash
    }
}
