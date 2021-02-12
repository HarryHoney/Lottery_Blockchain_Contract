pragma solidity ^0.4.17;

contract Lottery{
    
    address public manager;
    /*
    now we will make the manager of this lottery the person who will be creating it's instance
    we will be using 'msg' Global variable. It has following properties:
    msg.data, msg.gas, msg.sender, msg.value
    this msg property is available in both cases ie when we call a function or send a transaction
    */
    
    constructor() public {
         manager = msg.sender;
    }
    
    address[] public players;
    //the default function which will be created for this will accept the index number and then return value
    /*
    big Gotcha: we can't have array of array in our project. Now limitation is not on part of solidity. 
    Infact we can have array of array in solidity and save them in contracts as well. So is it JS code.
    No, it's not the js code, even that support array of arrays like [[1,2],[3,4]]. So what the actual problem. 
    problem here is the bridge between these two and that's web3. so if I can't transfer things that means i can use them
    array of strings is equalient to array of array so that's are  invalid as well.
    */
    
    function enter() public payable {//we have marked this function as payable because users will be sending some ether here
        require(msg.value > 0.01 ether);
        /*
        here require() function is also a Global function and use for validation 
        we can pass a boolean expression to this function and depending on that value the current method is futher 
        executed or not
        remember : msg.value is in wei but not in ether but we can type cast it in upper way
        */
        players.push(msg.sender);
    }
    
    function random() private view returns (uint){
        return uint(keccak256(block.difficulty,now,players));
        //keccak256 is algo of sha3 is a Global function here to get a hex number, block is Globalvariable
        
    }
    
    function pickWinner() public restricted {
        
        uint index = random() % players.length;
        
        //every address has a function associated with it called transfer to send money to that address
        //we will be sending all money from this constract to person
        players[index].transfer(this.balance);
        players = new address[](0);
        
    }
    
    modifier restricted(){
        require(msg.sender == manager);
        _;
    }
    
    function getPlayers() public view returns (address[]){
        return players;
    }
    
}