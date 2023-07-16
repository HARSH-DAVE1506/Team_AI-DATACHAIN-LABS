//SPDX-License-Identifier:MIT
pragma solidity ^0.8.9;

/**
 * @title AI imageGenerator storage Vessel
 * @author Darshil Mistry
 * @notice The contract is not tested
 */
contract AIThing {
    /// @dev this mapping stores the image prompt and the ipfs image uri
    struct Entries {
        string prompt;
        string image;
    }

    /// @dev mappings
    mapping(address => mapping(uint32 => Entries)) private PromptLogs;
    mapping(address => uint32) private UploadCount;
    mapping(uint256 => address) private AuthorisedPersonnel;
    uint8 private staffCount;

    /// @dev the owner of cntract and the deploer can not bechanged
    address private immutable i_owner;

    ///@dev this guy allows only authorised guys to handle certain functions
    modifier AuthorizedPersonneLOnly(uint8 userId) {
        require(
            AuthorisedPersonnel[userId] == msg.sender,
            "UnAuthorised, Access not granted"
        );
        _;
    }

    constructor() {
        i_owner = msg.sender;
        staffCount = staffCount + 1;
        AuthorisedPersonnel[staffCount] = msg.sender;
    }

    ///@dev this function would get the
    function storemyPrompt(
        string memory prompt,
        string memory imageURI
    ) public {
        Entries memory newEntry = Entries(prompt, imageURI);
        PromptLogs[msg.sender][UploadCount[msg.sender]] = newEntry;
        UploadCount[msg.sender] += 1;
    }

    function getImages(
        address genrator
    ) public view returns (Entries[] memory) {
        Entries[] memory history = new Entries[](UploadCount[msg.sender]);
        for (uint32 i = 0; i < UploadCount[msg.sender]; i++) {
            history[i] = PromptLogs[genrator][i];
        }
        return history;
    }

    function addPersonnel(
        address newUser,
        uint8 personnel
    ) public AuthorizedPersonneLOnly(personnel) returns (uint8) {
        staffCount = staffCount + 1;
        AuthorisedPersonnel[staffCount] = newUser;
        return (staffCount);
    }
}
