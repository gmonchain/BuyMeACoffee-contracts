// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract BuyMeACoffee {
    //Event to emit when a memo is created

    event NewMemo(

        address indexed from,
        uint256 timestamp,
        string name,
        string message


    );

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


    //Memo Struct
    struct Memo{
        address from;
        uint256 timestamp;
        string name;
        string message;

    }

    //List of all memos recieved from friends
    Memo[] memos;

    //Address of the contract deployer
    address payable owner;

    bool private paused;


    //Deploy logic

    constructor() {
        owner = payable(msg.sender);
        paused = false;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    modifier whenPaused() {
        require(paused, "Contract is not paused");
        _;
    }

    /*
    *   @dev Pause the contract. Only owner can call this.
    */
    function pause() public onlyOwner whenNotPaused {
        paused = true;
    }

    /*
    *   @dev Unpause the contract. Only owner can call this.
    */
    function unpause() public onlyOwner whenPaused {
        paused = false;
    }

    /*
    *   @dev Update the owner of the contract.
    *   @param _newOwner The address of the new owner.
    */
    function updateOwner(address payable _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner cannot be the zero address");
        address oldOwner = owner;
        owner = _newOwner;
        emit OwnershipTransferred(oldOwner, _newOwner);
    }

    /*
    *   @dev buy a cofee for contract owner
    *   @param _name name of the coffee buyer
    *   @param _message a nice message from the coffee buyer
    *
    */
    function buyCoffee(string memory _name,string memory _message) public payable whenNotPaused{

        require(msg.value >0 , "Can't buy coffee with 0 eth");

        //Add the memo to the storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        //Emit a log event when a new memo is created
       emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
        
    }



    /*
    *   @dev send the entire balance stored in this contract to the owner
    *   
    */
    function withdrawTips() public onlyOwner whenNotPaused {
        require(owner.send(address(this).balance));
    }



    /*
    *   @dev retrieve all the memos recieved and stored on the blockchain
    *   
    */
    function getMemos() public view returns(Memo[] memory){
        return memos;
    }
}