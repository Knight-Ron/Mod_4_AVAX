// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Mod_4 is ERC20 {
    uint public maxTransactionLimit = 800;
    address private contractOwner;

    struct ShopItem {
        string name;
        uint256 price;
    }

    ShopItem[] public shopItems;

    mapping(address => uint256) public balances;

    constructor() ERC20("My Token", "MYT") {
        contractOwner = msg.sender;
        _mint(msg.sender, 10 * 10 ** decimals()); // Mint 10 tokens initially to the contract deployer
        addItemToShop("Item 1", 5 * 10 ** decimals());
        addItemToShop("Item 2", 10 * 10 ** decimals());
        addItemToShop("Item 3", 15 * 10 ** decimals());
    }

    modifier onlyContractOwner {
        require(msg.sender == contractOwner, "Only contract owner can use this");
        _;
    }

    function mintTokens(address recipient, uint256 amount) public onlyContractOwner {
        require(amount > 0, "Amount must be greater than 0");
        require(balanceOf(contractOwner) >= amount, "Insufficient balance");

        _transfer(contractOwner, recipient, amount);
        balances[recipient] += amount;
    }

    function burnTokens(address recipient, uint256 amount) public {
        require(balances[recipient] >= amount, "Insufficient balance");

        if (amount > maxTransactionLimit) {
            revert("Transaction amount exceeds maximum allowed");
        }

        _burn(recipient, amount);
        balances[recipient] -= amount;
    }

    function setMaxTransaction(uint256 newMax) public onlyContractOwner {
        maxTransactionLimit = newMax;
    }

    function getContractOwner() public view returns (address) {
        return contractOwner;
    }

    function addItemToShop(string memory name, uint256 price) public onlyContractOwner {
        shopItems.push(ShopItem(name, price));
    }

    function redeemItem(uint256 index) public {
        require(index < shopItems.length, "Invalid item index");

        ShopItem storage item = shopItems[index];
        require(balanceOf(msg.sender) >= item.price, "Insufficient balance");

        _transfer(msg.sender, contractOwner, item.price);
    }

    function getShopItems() public view returns (ShopItem[] memory) {
        return shopItems;
    }
}
