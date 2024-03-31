// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract CoinFlip{
    address p1;
    bytes32 hashVal;
    address p2;
    uint val;

    function hashWithSalt(uint value, string memory salt) public pure returns (bytes32) {
        require(value == 0 || value == 1, "Please enter value between 0 and 1");
        return keccak256(abi.encodePacked(value, salt));
    }

    function commitValue(bytes32 hash) public payable {
        require(p1 == address(0));
        require(p2 == address(0));
        require(msg.value == 1 ether);
        p1 = msg.sender;
        hashVal = hash;
    }

    function guessValue(uint value) public payable {
        require(value == 0 || value == 1, "Please enter value between 0 and 1");
        require(p1 != address(0));
        require(p2 == address(0));
        require(msg.value == 1 ether);
        p2 = msg.sender;
        val = value;
    }

    function revealValue(uint value, string memory salt) public {
        require(value == 0 || value == 1, "Please enter value between 0 and 1");
        require(p1 != address(0));
        require(p2 != address(0));
        require(hashWithSalt(value, salt) == hashVal);
        if (value == val){
            payable(p2).transfer(2 ether);
        }
        else{
            payable(p1).transfer(2 ether);
        }
    }
}