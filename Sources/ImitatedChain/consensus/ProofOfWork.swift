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
    private let target = "0001000000111111111111111111111111111111111111111111111111111111";
    private let merkleRoot: String;
    
    init(merkleRoot: String) {
        self.merkleRoot = merkleRoot;
    }
    
    func exec(for block: Block) -> Block {
        var hash = "";
        var nonce = 0;
        var timeStamp = Date()
        
        while true {
            hash = calcHash(nonce: nonce, timeStamp: timeStamp)
            if target > hash { break }
            nonce += 1
            timeStamp = Date()
        }
        
        block.header.nonce = nonce
        block.header.timeStamp = timeStamp
        block.header.hash = hash
        return block;
    }
    
    func calcHash(nonce: Int, timeStamp: Date) -> String {
        let rawData: String = BlockChain.shared.latestBlock.header.hash! + merkleRoot + String(nonce) + String(Int(timeStamp.timeIntervalSince1970))
        let sha3 = SHA3(variant: .sha512)
        let digest = sha3.calculate(for: rawData.bytes)
        let blockHash = "0x" + digest.reduce("") { $0 + String(format: "%02x", $1) }
        return blockHash
    }
}
