// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Import this file to use console.log
// import "hardhat/console.sol";

contract BuyMeACoffee {
    // Event to emit when a memo is created
    event NewMemo (
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    // memo struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received
    Memo[] memos;

    //address of contract deployer
    address payable owner;

    //deploy logic
    constructor() {
        owner = payable(msg.sender);
    }

    /*
    * @dev buy a coffee for contract owner
    * @param _name name of the coffee buyer
    * @param _message a nice message from the buyer
    */
    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "cant buy coffee with 0 eth");

        //add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));

        //emit a log event when a new memo is created
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );
    }

    /*
    * @dev send the entire balance stored in this contract to the owner
    */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /*
    * @dev retrieve all the memos received and stored on the blockchain
    */
    function getMemos() public view returns(Memo[] memory) {
        return memos;
    }

}
