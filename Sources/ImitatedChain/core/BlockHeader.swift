//
//  BlockHeader.swift
//  CryptoSwift
//
//  Created by 刈部拓未 on 2018/08/13.
//

import Foundation

struct BlockHeader {
    let hash: String
    let preHash: String
    let merkleRoot: String
    let stateRoot: String = ""
    let nonce: Int
    let timeStamp: Date
}
