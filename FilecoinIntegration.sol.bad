//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title file uploader
/// @author idarshilmistry
/// @notice This might be buggy

contract UntitledContract {
    /// @dev Variables and mappings

    /// @dev the information we take from the uploder
    struct FileDetails {
        bytes32 dealId;
        address owner;
        string projectTitle;
        uint8 kloc;
        bytes fileData;
    }

    struct userReviews {
        uint8 strars;
        string reviw;
    }

    /// @dev this guy would store all the files ever uploaded by some dude
    mapping(address => mapping(uint32 => FileDetails)) private files;
    /// @dev this guys facilitates above concept and can be seen as a trophy ofsorts
    mapping(address => uint32) private uploadCounter;
    /// @dev this would store access fo particulr files for specific users
    mapping(uint32 => mapping(address => uint)) fileAccess;
    /// @dev this would keep trak of views and would be used in above mapping
    mapping(uint32 => uint) fileViews;
    mapping(uint32 => mapping(address => userReviews)) reviews;

    /// @dev events
    event FileUploaded(address indexed user, bytes32 dealId);

    /// @devfunctions

    /// @param details it takes filedetails, the struct
    /// @notice this guy would just initiate the process another function would be called by it
    /// @dev add  the return stmt and the evnt
    function initiateFile(FileDetails memory details) public {
        uint32 newId = uploadCounter[msg.sender] + 1;
        files[msg.sender][newId] = details;
    }

    /// @dev funtion to provide access
    function giveAccess(address payer, uint32 uploadID) private {
        fileViews[uploadID] += 1;
        fileAccess[uploadID][payer] = fileViews[uploadID];
    }

    function review(uint32 file, uint8 p_stars, string memory p_review) public {
        uint payeridx = fileAccess[file][msg.sender];
        require(payeridx, "bhaibad review krva pehla levu pade");
        userReviews memory review = [p_stars, p_review];
        reviews[file][msg.sender] = review
    }

    function billing(address payer, uint32 uploadID) public payable {
        giveAccess(payer, uploadID);
    }

    /// @dev if u find any upload function put it in here
    function upload(FileDetails calldata details) private returns (bool) {}

    /// @dev viev/pure functions
}
