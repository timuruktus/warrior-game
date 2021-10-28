pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';
import 'MilitaryUnitInterface.sol';

contract BaseStation is GameObject{

    MilitaryUnitInterface[] private units;
    mapping (address => uint) addressToUnitId;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        protectionValue = 5;
    }

    function addUnit(MilitaryUnitInterface unit) public{
        tvm.accept();
        addressToUnitId[address(unit)] = units.length;
        units.push(unit);
    }

    function deleteUnit(MilitaryUnitInterface unit) public{
        tvm.accept();
        uint id = addressToUnitId[address(unit)];
        delete units[id];
        delete addressToUnitId[unit];
    }

    function die(address whoKilled) internal override {
        tvm.accept();
        for(uint i = 0; i < units.length; i++){
            units[i].baseStationDead(address(this));
        }
        super.die(whoKilled);
    }

    function getUnits() public returns(MilitaryUnitInterface[]){
        tvm.accept();
        return units;
    }

}
