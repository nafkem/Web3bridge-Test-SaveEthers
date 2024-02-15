// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {
    string private _name;
    string private _symbol;
    uint256 private _tokenIdCounter;

    mapping(uint256 => address) private _tokenOwners;
    mapping(address => uint256) private _ownershipTokenCount;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _userApprovals;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed user, bool approved);

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _ownershipTokenCount[owner];
    }
function ownerOf(uint256 tokenId) external view returns (address) {
    require(_exists(tokenId), "ERC721: owner query for nonexistent token");
    return _tokenOwners[tokenId];
}

    function ownerOf(uint256 tokenId) external view returns (address) {
    require(_exists(tokenId), "ERC721: owner query for nonexistent token");
    return _tokenOwners[tokenId];
}
    function approve(address to, uint256 tokenId) external {
        address owner = ownerOf(tokenId);
        require(to != owner, "ERC721: approval to current owner");
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender), "ERC721: approve caller is not owner nor approved for all");

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) external view returns (address) {
        require(_exists(tokenId), "ERC721: approved query for nonexistent token");
        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address user, bool approved) external {
        require(user != msg.sender, "ERC721: approve to caller");
        _userApprovals[msg.sender][user] = approved;
        emit ApprovalForAll(msg.sender, user, approved);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _userApprovals[owner][operator];
    }

    function transferFrom(address from, address to, uint256 tokenId) external {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");
        _transfer(from, to, tokenId);
    }
    function ownerOf(uint256 tokenId) external view returns (address) {
    return _tokenOwners[tokenId];
}

    function safeTransferFrom(address from, address to, uint256 tokenId) external {
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        require(_isApprovedOrOwner(msg.sender, tokenId), "ERC721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
    }

    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) internal {
        _transfer(from, to, tokenId);
        
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        return _tokenOwners[tokenId] != address(0);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "ERC721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    function _transfer(address from, address to, uint256 tokenId) internal {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _clearApproval(tokenId);
        _ownershipTokenCount[from]--;
        _ownershipTokenCount[to]++;
        _tokenOwners[tokenId] = to;

        emit Transfer(from, to, tokenId);
    }

    function _clearApproval(uint256 tokenId) private {
    if (_tokenApprovals[tokenId] != address(0)) {
        _tokenApprovals[tokenId] = address(0);
    }
} 


    function _safeMint(address to, uint256 tokenId) internal {
        _safeMint(to, tokenId, "");
    }

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _tokenOwners[tokenId] = to;
        _ownershipTokenCount[to]++;
        emit Transfer(address(0), to, tokenId);
    }

    function _burn(uint256 tokenId) internal {
        address owner = ownerOf(tokenId);

        _clearApproval(tokenId);
        _ownershipTokenCount[owner]--;
        _tokenOwners[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }

}
