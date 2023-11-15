// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract KYCPrototype {
    // Struct to represent customer information
    struct Customer {
        address customerAddress;
        string name;
        string documentHash; // Hash of the customer's primary document
        bool isVerified;
    }

    address public admin;

    constructor(){
        admin = msg.sender;
    }

    // Mapping to store customer information
    mapping(address => Customer) public customers;

    // Event to log KYC verification status
    event KYCVerified(address indexed customerAddress, bool isVerified);

    // Modifier to ensure only authorized entities can perform certain actions
    modifier onlyAuthorized {
        // Implement your authorization logic here
        require(msg.sender == admin, "Not authorized");
        _;
    }

    // Function to submit KYC information
    function submitKYC(string memory _name, string memory _documentHash) external {
        // Check if the customer is not already registered
        require(customers[msg.sender].customerAddress == address(0), "Customer already registered");

        // Store customer information
        customers[msg.sender] = Customer({
            customerAddress: msg.sender,
            name: _name,
            documentHash: _documentHash,
            isVerified: false
        });
    }

    // Function to verify KYC
    function verifyKYC(address _customerAddress) external onlyAuthorized {
        // Check if the customer exists
        require(customers[_customerAddress].customerAddress != address(0), "Customer not found");

        // Mark the customer as verified
        customers[_customerAddress].isVerified = true;

        // Emit KYC verification event
        emit KYCVerified(_customerAddress, true);
    }

    // Function to get KYC status
    function getKYCStatus(address _customerAddress) external view returns (bool) {
        return customers[_customerAddress].isVerified;
    }
}
