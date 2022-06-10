//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "hardhat/console.sol";

contract ConnectedAccountsSave {
    constructor() {
        // Создание тестовых аккаунтов
        accounts.push(Account(1, "id_name_1", "dmiltas", 1, 1));
        accounts.push(Account(2, "id_name_2", "reilgelrn", 2, 1));
        accounts.push(Account(3, "id_name_3", "deokneks", 2, 1));
        accounts.push(Account(4, "id_name_4", "kaizda", 3, 1));
        accounts.push(Account(5, "id_name_5", "straid", 3, 1));
        accounts.push(Account(6, "id_name_6", "trains", 3, 1));

        // Происхождение (откуда аккаунт присоеденился к нам)
        // В account.push -- это 4 аргумент
        origins.push(Origin("Twitter")); // 1
        origins.push(Origin("Instagram")); // 2
        origins.push(Origin("Gmail.com")); // 3

        // ASN -- это например с первого ко второму
        // ALN -- counter (1,2,3,4,5). Upper with everyone element
        // Name -- account display name. Example name Daniil (my name in Twitter)
        // Origin Id -- id from where the account decided to connect. Example, Twitter, Gmail
        // Status -- status (1 - active, 2 - progress)
        links.push(AccountLink(2, 1, 1, 0));
        links.push(AccountLink(2, 2, 1, 0));
        links.push(AccountLink(3, 3, 1, 0));
        links.push(AccountLink(4, 4, 1, 0));
    }

    // **************
    // Structs
    // **************
    struct Account {
        uint64 asn; // account sequence number. at least uint64
        string id; // immutable account id, unique in the network's scope.
        string name; // account display name
        uint256 originId; // reference to network record
        uint256 status; // ToDo: workflow dependent status.
        // 0 - OK (account is fully usable)
        // >0 - any internal processing status (dependent on verification process).
    } // where ID is the implementation ID-reference type.

    struct AccountLink {
        uint64 asn; // account asn as id. Target account
        uint64 aln; // link sequence number for this link.
        uint64 status; // link status bit mask (active, suspended, etc)
        uint64 _reserved; // reserved for now.
    }

    struct Origin {
        string name; //a public name unique accross all implementations of all blockchains. Example Twitter or Instagram;
    }

    struct Witnesses {
        bytes data;
    }

    // **************
    // Arrays
    // **************
    Account[] public accounts; // vector storing all accounts
    Origin[] public origins; //
    AccountLink[] public links; //
    // asn : uint64            // monotone account counter.
    // aln : uint64            // monotone link counter.

    // **************
    // Mappings
    // **************

    // Account Id + Origin Id (Name) => Keccak-256
    mapping(uint256 => uint64) public accountIdByHash;

    // Account Id => Arr Links
    mapping(uint64 => AccountLink[]) public accountLinks;

    // Writes Witnesses
    mapping(uint64 => Witnesses[]) public linkWitnesses;

    // Type AccountGroups = MAP<uint64:AccountLink[]>
    //                         // a map storing double linked account grouping graph
    // Type witnesses =  MAP<uint64:hash256>  // aln=>hash
    //                         // a map storing hash links to external storage of link witnesses

    // FUNCTIONS

    // Returns the entire group of linked accounts for a specific account
    function getConnectedGroup(uint64 accountFrom)
        public
        view
        returns (AccountLink[] memory)
    {
        return accountLinks[accountFrom];
    }

    // uint64 - account 1
    // uint64 - account 2

    // Creates a ready link
    // function createLink(uint64 accountFromIndex, uint64 accountTo) public {
    //     require(
    //         accountFromIndex < accounts.length,
    //         "The account does not exist"
    //     );

    //     // Added new
    //     accountLinks[accountFromIndex] = links.length;

    // Write the AccountLink structure
    // links.push({
    //     asn: accountTo;      // account asn as id. Target account
    //     aln: aln++;     // link sequence number for this link.
    //     status: 1;   // link status bit mask (active, processing, suspended, etc)
    //     _reserved: 0; // reserved for now.
    // });
    // }

    // active - 1
    // processing - 2

    // Initializes a link, which Oracle then validates

    // function initLink(uint64 accountFromIndex, uint64 accountTo) public {
    //     require(
    //         accountFromIndex < accounts.length,
    //         "The account does not exist"
    //     );
    //     // Added new
    //     accountLinks[accountFromIndex].push(links.length);

    //     // Write the strucrure AccountLink
    //     // links.push({
    //     //     asn: accountTo;      // account asn as id. Target account
    //     //     aln: aln++;     // link sequence number for this link.
    //     //     status: 2;   // link status bit mask (active, processing, suspended, etc)
    //     //     _reserved: 0; // reserved for now.
    //     // });
    // }

    // Already Link,
    // accountFromIndex -- central node (where the account comes from)
    // linkNum -- this is the account number to verify
    function confirmLink(uint64 linkId) public {
        require(linkId < accounts.length, "The account does not exist");

        // Write the Account Link structure
        links[linkId].status = 1;
    }

    // 1. Find an array of links (accountFrom) and remove the required one (linkNum)
    // function disconnectLink(uint64 accountFromIndex, uint64 linkNum) public {
    //     links = accountLinks[accountFromIndex];
    //     links[linkNum] = links[links.length - 1];
    //     delete links[links.length - 1];
    //     if (links.length == 0) delete accountLinks[accountFromIndex];
    // }

    // function getAccontsById(uint64[] accountIds)
    //     public
    //     view
    //     returns (string[] origin, Account[] memory accounts) {

    // }
}
