// SPDX-License-Identifier: Apache-2.0
pragma solidity >=0.8.0;

import "@iconfoundation/btp2-solidity-library/contracts/interfaces/ICallService.sol";
import "@iconfoundation/btp2-solidity-library/contracts/interfaces/ICallServiceReceiver.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

abstract contract PartyReader is ICallService, ERC20, ERC20Burnable{
    //uint256 private _count = 0;
    address private _owner;
    
    constructor() ERC20("Party", "PRD") {
        _owner = msg.sender;
    }
    modifier own(){
        require(msg.sender == _owner);
        _;
    }
    /*
    * @dev Mint token on data owner blockchain
    * MUST be ERC20
    */
    function readerMint(string memory uri, bytes memory user) external virtual own{
        //_count = _count + 1;
       _mint(_owner, 2);
       bytes memory data = user;
       sendCallMessage(user, data, "");  
    }
    /*
    * @dev Burn a given token by the owner
    */
    function readerBurn(uint256 val) external virtual own{
        burn(val);
        
    }


}