pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

import 'GameObject.sol';
import 'BaseStation.sol';
import 'MilitaryUnitInterface.sol';

contract MilitaryUnit is GameObject, MilitaryUnitInterface{

    BaseStation private baseStation;
    uint attackValue;
    uint constant BASIC_ATTACK_VALUE = 5;


    constructor(BaseStation _baseStation) public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        baseStation = _baseStation;
        baseStation.addUnit(this);
        attackValue = BASIC_ATTACK_VALUE;
    }

    function baseStationDead(address whoKilled) external override{
        tvm.accept();
        require(whoKilled == address(baseStation), 201);
        super.die(whoKilled);
    }

    function attack(GameObjectInterface gameObject) public checkOwnerAndAccept{
        gameObject.damage(attackValue);
    }

    function getAttackValue() public checkOwnerAndAccept returns(uint){
        tvm.accept();
        return attackValue;
    }

    function die(address whoKilled) virtual internal override{
        tvm.accept();
        baseStation.deleteUnit(this);
        super.die(whoKilled);
    }

    function getBaseStation() public returns(BaseStation){
        tvm.accept();
        return baseStation;
    }

}
