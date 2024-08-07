// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SimpleAssetTransfer {
struct Asset {
string name;
address owner;
}
mapping(uint256 => Asset) public assets;
mapping(address => uint256[]) private ownerAssets;
event AssetTransferred(uint256 indexed assetId, address indexed from, 
address indexed to);
function createAsset(uint256 _id, string memory _name) public {
assets[_id] = Asset(_name, msg.sender);
ownerAssets[msg.sender].push(_id);
}
function transferAsset(uint256 _assetId, address _to) public {
require(assets[_assetId].owner == msg.sender, "Not the asset owner");
require(_to != address(0), "Invalid recipient address");
address previousOwner = assets[_assetId].owner;
assets[_assetId].owner = _to;
removeAssetFromOwner(previousOwner, _assetId);
ownerAssets[_to].push(_assetId);
emit AssetTransferred(_assetId, previousOwner, _to);
}
function getAssetOwner(uint256 _assetId) public view returns (address) {
return assets[_assetId].owner;
}
function getOwnerAssets(address _owner) public view returns (uint256[] 
memory) {
return ownerAssets[_owner];
}
function removeAssetFromOwner(address _owner, uint256 _assetId) internal {
uint256[] storage assetsOfOwner = ownerAssets[_owner];
for (uint256 i = 0; i < assetsOfOwner.length; i++) {
if (assetsOfOwner[i] == _assetId) {
assetsOfOwner[i] = assetsOfOwner[assetsOfOwner.length - 1];
assetsOfOwner.pop();
break;
}
}
}
}
