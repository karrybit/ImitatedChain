//
//  BlockChain.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation
import CryptoSwift

final class BlockChain {
    static let shared = BlockChain()
    private(set) var blocks: [Block] = []
    var latestIndex: Int { return blocks.count - 1 }
    var latestBlock: Block { return blocks.last! }
    
    private init() {}
    
    func createGenesisBlock(by merkleRoot: String) {
        let sha3 = SHA3(variant: .sha512)
        let digest = sha3.calculate(for: "genesis block".bytes)
        let hash = "0x" + digest.reduce("") { $0 + String(format: "%02x", $1) }
        let block = Block(preHash: "0x0000000000000000000000000000000000000000000000000000000000000000",
                          merkleRoot: merkleRoot)
        block.header.hash = hash
        block.header.nonce = 42
        block.header.timeStamp = Date()
        blocks.append(block)
    }
    
    func append(_ block: Block) {
        blocks.append(block)
    }
}
