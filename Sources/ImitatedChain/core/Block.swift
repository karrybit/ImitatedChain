//
//  Block.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation

final class Block {
    private let height: Int = 0
    private let blockHeader: BlockHeader;
    private var transactions: [Transaction] = [];
    
    init(previousHash: String, blockHash: String, merkleRoot: String, nonce: Int, timeStamp: Date) {
        self.blockHeader = BlockHeader(previousHash: previousHash,
                                       blockHash: blockHash,
                                       merkleRoot: merkleRoot,
                                       nonce: nonce, timeStamp: timeStamp)
    }
}
