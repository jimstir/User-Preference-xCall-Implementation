// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@iconfoundation/btp2-solidity-library/contracts/interfaces/ICallService.sol";
import "@iconfoundation/btp2-solidity-library/contracts/interfaces/ICallServiceReceiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

abstract contract UserIdentity is ERC721URIStorage, ICallService{
    
    uint256 private _count;
    uint256 private _supply;
    address private _owner;
    address private _xCaller;

    // approved addresses to create activity nft with proof of prefrence compliance nft(DID
    mapping(address => bool) public approveId;
    mapping(address => string) private _didInfo;
   
    mapping(address => bytes32) private _userPref;
    
   
    struct Action{
        int action;
        address user;
        string uri;
    }

     event MessageRecieved(
        string indexed from,
        Action indexed cho
    );

    
    constructor(address caller) ERC721("IDentity", "IDS"){
        _count = 0;
        _owner = msg.sender;
        _xCaller = caller;
    }
    modifier xCall(){
        require(msg.sender == _xCaller);
        _;
    }

    /*
    * @dev Get the preference link stored in tokenURI
    */
    function getPref(address user) public view returns(bytes32){
        return _userPref[user];
    }
    /*
    * @dev Get the activity link stored in tokenURI
    */
    function getActivityPref(uint256 id) public view returns(string memory){
        return tokenURI(id);
    }
    /*
    * @dev Get the approved address for this issuer
    */
    function approvedAccess(address user) public view returns(bool){
        return approveId[user];
    }
    /*
    * @dev Get DID URL
    */
    function didInfo(address user) external view returns(string memory){
        return _didInfo[user];
    }
    
    /*
    * @dev Add preference for a user, should link to user preference 
    */
    function addPref(bytes32 pref) external virtual{
        _userPref[msg.sender] = pref;
    }
    /*
    * @dev Approve addresses to use activityMint
    */
    function addParty(address user, string memory uri) external virtual {
        require(msg.sender == _owner);
        approveId[user] = true;
        _didInfo[user] = uri;
    }
    /*
    * @dev Mint nft token for each activity
    * MUST be approved DID address
    * MUST be ERC721 token
    */
    function activityMint(address from, address to, string memory uri) internal virtual{
        require(approveId[from]);
        _supply = _supply + 1;
        _safeMint(to, _supply);
        _setTokenURI(_supply, uri);
    }

    function handleCallMessage(string calldata _from, Action calldata auth) external xCall returns (bytes32){
        address from = address(bytes20(bytes(_from)));
        emit MessageRecieved(_from, auth);
        if(0 == auth.action){
            revert();
        }
        if(1 == auth.action){
            return getPref(auth.user);
        }
        if(2 == auth.action){
            activityMint(from, auth.user, auth.uri);
        }
        
    }

   
}