import Foundation

let merkleRoot: String = "0x0"
BlockChain.shared.createGenesisBlock(by: merkleRoot)

for _ in 0..<10 {
    let result = ProofOfWork.exec()
    let header = BlockHeader(hash: result.hash,
                             preHash: BlockChain.shared.latestBlock.header.hash,
                             merkleRoot: merkleRoot,
                             nonce: result.nonce,
                             timeStamp: result.timeStamp)
    let block = Block(header: header)
    BlockChain.shared.append(block)
}

for i in 0...10 {
    print("*** Block \(i) ***")
    print("TimeStamp: \(BlockChain.shared.blocks[i].header.timeStamp)")
    print("Hash: \(BlockChain.shared.blocks[i].header.hash)")
    print("Previous Hash: \(BlockChain.shared.blocks[i].header.preHash)")
    print("Nonce: \(BlockChain.shared.blocks[i].header.nonce)")
}
