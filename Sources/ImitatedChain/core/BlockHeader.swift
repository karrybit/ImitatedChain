//
//  BlockHeader.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation

final class BlockHeader {
    var preHash: String
    var hash: String?
    var merkleRoot: String
    let stateRoot: String = ""
    var nonce: Int?
    var timeStamp: Date?
    
    init(preHash: String, merkleRoot: String) {
        self.preHash = preHash;
        self.merkleRoot = merkleRoot;
    }
}
