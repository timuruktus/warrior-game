
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'MilitaryUnit.sol';

contract Warrior is MilitaryUnit {


    constructor(BaseStation _baseStation) MilitaryUnit(_baseStation) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        attackValue = 8;
        protectionValue = 0;
    }


}

