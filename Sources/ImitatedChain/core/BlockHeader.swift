//
//  BlockHeader.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation

final class BlockHeader {
    let previousHash: String
    let blockHash: String
    let merkleRoot: String
    let stateRoot: String = ""
    let nonce: Int
    let timeStamp: Date
    
    init(previousHash: String, blockHash: String, merkleRoot: String, nonce: Int, timeStamp: Date) {
        self.previousHash = previousHash;
        self.blockHash = blockHash;
        self.merkleRoot = merkleRoot;
        self.nonce = nonce;
        self.timeStamp = timeStamp;
    }
}
