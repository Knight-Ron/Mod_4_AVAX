# Mod_4 Token Contract

## Overview
The `Mod_4` contract is an ERC-20 token contract with additional functionality for managing shop items and allowing users to redeem items with tokens.

## Token Details
- **Token Name:** My Token
- **Token Symbol:** MYT
- **Initial Supply:** 10 MYT tokens minted to the contract deployer

## Features
- **Max Transaction Limit:** Ensures that no transaction exceeds the specified limit.
- **Shop Items:** Allows the contract owner to add items to a shop, and users can redeem these items using tokens.

## Functions

### Public Functions

- **mintTokens(address recipient, uint256 amount)**

  Mints tokens and transfers them to the specified recipient. Only the contract owner can call this function.
  
  ```solidity
  function mintTokens(address recipient, uint256 amount) public onlyContractOwner
  ```

- **burnTokens(address recipient, uint256 amount)**

  Burns the specified amount of tokens from the recipient's balance. Ensures that the amount does not exceed the maximum transaction limit.
  
  ```solidity
  function burnTokens(address recipient, uint256 amount) public
  ```

- **setMaxTransaction(uint256 newMax)**

  Sets a new maximum transaction limit. Only the contract owner can call this function.
  
  ```solidity
  function setMaxTransaction(uint256 newMax) public onlyContractOwner
  ```

- **getContractOwner()**

  Returns the address of the contract owner.
  
  ```solidity
  function getContractOwner() public view returns (address)
  ```

- **addItemToShop(string memory name, uint256 price)**

  Adds a new item to the shop. Only the contract owner can call this function.
  
  ```solidity
  function addItemToShop(string memory name, uint256 price) public onlyContractOwner
  ```

- **redeemItem(uint256 index)**

  Allows users to redeem an item from the shop using tokens. Transfers the item's price in tokens from the user to the contract owner.
  
  ```solidity
  function redeemItem(uint256 index) public
  ```

- **getShopItems()**

  Returns a list of all items in the shop.
  
  ```solidity
  function getShopItems() public view returns (ShopItem[] memory)
  ```

## Modifiers

- **onlyContractOwner**

  Ensures that only the contract owner can call certain functions.
  
  ```solidity
  modifier onlyContractOwner
  ```

## Data Structures

- **ShopItem**

  Represents an item in the shop with a name and a price.
  
  ```solidity
  struct ShopItem {
      string name;
      uint256 price;
  }
  ```

- **Balances Mapping**

  Tracks the balance of tokens for each address.
  
  ```solidity
  mapping(address => uint256) public balances
  ```

## Example Usage

1. Deploy the contract.
2. The contract owner mints tokens and adds items to the shop.
3. Users can redeem items from the shop using their tokens.

## License

This contract is licensed under the MIT License.
