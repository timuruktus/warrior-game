
import 'GameObjectInterface.sol';

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract GameObject is GameObjectInterface{

    int internal health;
    uint internal protectionValue;
    uint16 constant SEND_ALL_AND_DESTROY_FLAG = 160;

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        health = 10;
        protectionValue = 3;
    }

    modifier checkOwnerAndAccept(){
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }

    function damage(uint _damage) external override{
        tvm.accept();
        if(_damage <= protectionValue) return;
        health = health - int(_damage) + int(protectionValue);
        if(isObjectDead()) die(msg.sender);
    }

    function getProtectionValue() public returns(uint){
        tvm.accept();
        return protectionValue;
    }

    function isObjectDead() private returns(bool){
        tvm.accept();
        return health <= 0;
    }

    function die(address whoKilled) virtual internal{
        tvm.accept();
        whoKilled.transfer(0, true, SEND_ALL_AND_DESTROY_FLAG);
    }

    function getHealth() public returns(int){
        tvm.accept();
        return health;
    }
    
}
