//
//  BlockChain.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation
import CryptoSwift

final class BlockChain {
    private var blocks: [Block] = []
    var latestIndex: Int { return blocks.count - 1 }
    var latestBlock: Block { return blocks.last! }
    
    func createGenesisBlock(by merkleRoot: String) {
        let sha3 = SHA3(variant: .sha512)
        let digest = sha3.calculate(for: "genesis block".bytes)
        let blockHash = "0x" + digest.reduce("") {$0 + String(format: "%02x", $1)}
        let block = Block(previousHash: "0x0000000000000000000000000000000000000000000000000000000000000000",
                          blockHash: blockHash,
                          merkleRoot: merkleRoot,
                          nonce: 42,
                          timeStamp: Date())
        blocks.append(block)
    }
}
