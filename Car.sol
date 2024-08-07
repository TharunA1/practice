// SPDX-License-Identifier: MIT

contract CarAuction {
    struct Auction {
        uint256 carId;
        string carName;
        uint256 startingPrice;
        uint256 endTime;
    }

    Auction[] public auctions;

    event AuctionCreated(uint256 auctionId, uint256 carId, string carName, uint256 startingPrice, uint256 endTime);

    function createAuction(uint256 _carId, string memory _carName, uint256 _startingPrice, uint256 _endTime) public {
        Auction memory newAuction = Auction({
            carId: _carId,
            carName: _carName,
            startingPrice: _startingPrice,
            endTime: _endTime
        });
        auctions.push(newAuction);

        uint256 auctionId = auctions.length - 1;
        emit AuctionCreated(auctionId, _carId, _carName, _startingPrice, _endTime);
    }

    function getAllAuctions() public view returns (Auction[] memory) {
        return auctions;
    }
    function getAuctionByCarId(uint256 _carId) public view returns (Auction memory) {
        return auctions[_carId];
    }
}
