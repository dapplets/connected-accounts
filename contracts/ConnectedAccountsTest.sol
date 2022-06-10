//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract ConnectedAccountsTest {
    constructor() {
        // Создание тестовых аккаунтов
        // for (uint256 i = 1; i < 100; i++) {
        //     accounts.push(
        //         Account(
        //             uint64(i),
        //             string.concat("id_name_", Strings.toString(i)),
        //             string.concat("dmiltas_", Strings.toString(i)),
        //             1,
        //             1
        //         )
        //     );
        // }
        // console.log(string.concat("id_name_", Strings.toString(1)));
        // accounts.push(Account(1, "id_name_1", "dmiltas", 1, 1));
        // accounts.push(Account(2, "id_name_2", "reilgelrn", 2, 1));
        // accounts.push(Account(3, "id_name_3", "deokneks", 2, 1));
        // accounts.push(Account(4, "id_name_4", "kaizda", 3, 1));
        // accounts.push(Account(5, "id_name_5", "straid", 3, 1));
        // accounts.push(Account(6, "id_name_6", "trains", 3, 1));
        // accounts.push(Account(7, "id_name_8", "train", 3, 1));
        // accounts.push(Account(8, "id_name_9", "train2", 3, 1));
        // accounts.push(Account(9, "id_name_10", "train3", 3, 1));
        // accounts.push(Account(10, "id_name_11", "train4", 3, 1));
        // Происхождение (откуда аккаунт присоеденился к нам)
        // В account.push -- это 4 аргумент
        // origins.push("Twitter"); // 1 0
        // origins.push("Instagram"); // 2 1
        // origins.push("Gmail.com"); // 3 2
        // origins.push("Mail.ru"); // 4 3
        // for (uint256 j = 0; j < accounts.length - 1; j++) {
        //     // j < accounts.length - 1
        //     _link(uint64(j), uint64(j + 1), 1);
        // }
        // _link(0, 1, 1);
        // _link(0, 2, 1);
        // _link(0, 3, 1);
        // _link(1, 2, 1);
        // _link(2, 4, 1);
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
        //uint64 aln; // link sequence number for this link.
        uint64 status; // link status bit mask (active, suspended, etc)
        uint64 _reserved; // reserved for now.
    }

    struct Origin {
        string name; //a public name unique accross all implementations of all blockchains. Example Twitter or Instagram;
    }

    struct Witnesses {
        bytes data;
    }

    function _link(
        uint64 an1,
        uint64 an2,
        uint64 status
    ) internal {
        // console.log(an1, an2, status);
        Account memory a1 = accounts[an1];
        Account memory a2 = accounts[an2];

        bytes32 createHash = keccak256(
            abi.encodePacked(a1.id, origins[a1.originId])
        );
        // console.log(a1.id, origins[a1.originId]);
        // console.logBytes32(hash_1);
        accountLinks[createHash].push(AccountLink(an2, status, 0));
        accountLinks[keccak256(abi.encodePacked(a2.id, origins[a2.originId]))]
            .push(AccountLink(an1, status, 0));
    }

    // **************
    // Arrays
    // **************
    Account[] public accounts; // vector storing all accounts
    string[] public origins; //
    // asn : uint64            // monotone account counter.
    // aln : uint64            // monotone link counter.

    // **************
    // Mappings
    // **************

    // keccak256(Account Id + Origin (Name)) => account id
    mapping(uint256 => uint64) public accountIdByHash;

    // Account Id => Arr Links
    mapping(bytes32 => AccountLink[]) public accountLinks;

    // Writes Witnesses
    mapping(uint64 => Witnesses[]) public linkWitnesses;

    // Type AccountGroups = MAP<uint64:AccountLink[]>
    //                         // a map storing double linked account grouping graph
    // Type witnesses =  MAP<uint64:hash256>  // aln=>hash
    //                         // a map storing hash links to external storage of link witnesses

    // FUNCTIONS

    function createTestAccounts(uint256 _length) public {
        for (uint256 i = 0; i < _length; i++) {
            accounts.push(
                Account(
                    uint64(i),
                    string.concat("id_name_", Strings.toString(i)),
                    string.concat("dmiltas_", Strings.toString(i)),
                    1,
                    1
                )
            );
        }
        origins.push("Twitter"); // 1, index 0
        origins.push("Instagram"); // 2, index 1
        origins.push("Gmail.com"); // 3, index 2
        origins.push("Mail.ru"); // 4, index 3

        console.log(
            string.concat(
                "Account Created",
                " ",
                Strings.toString(accounts.length)
            )
        );

        for (uint256 j = 0; j < accounts.length - 1; j++) {
            // j < accounts.length - 1
            _link(uint64(j), uint64(j + 1), 1);
        }
    }

    // Returns the entire group of linked accounts for a specific account
    function getConnectedGroupPayable(bytes32 accountHash)
        public
        payable
        returns (AccountLink[] memory out)
    {
        return getConnectedGroup(accountHash);
    }

    // Returns the entire group of linked accounts for a specific account
    function getConnectedGroup(bytes32 accountHash)
        public
        view
        returns (AccountLink[] memory out)
    {
        // console.logBytes32(accountHash);

        console.log(
            string.concat(
                "getConnectedGroup",
                " ",
                Strings.toString(accounts.length)
            )
        );

        AccountLink[] memory _outdata = new AccountLink[](accounts.length);
        uint256 n = _fetch(_outdata, accountHash, 0);
        // console.log(n);
        //uint256 n = 0;
        out = new AccountLink[](n);
        for (uint256 i = 0; i < n; i++) {
            out[i] = _outdata[i];
        }
    }

    function _fetch(
        // _outData -- пустой массив, который будет впоследствии заполняться и возвращаться
        AccountLink[] memory _outData,
        // accountHash - это хеш, который мы получаем через keckak256(name + ac)
        bytes32 accountHash,
        // _buflen - сохраняет текущую длину и возврвщает её
        uint256 _buflen
    ) internal view returns (uint256) {
        AccountLink[] memory al = accountLinks[accountHash];

        // TODO: Нужно протестировать. Возможно передеавать al.length -- не будет экономить
        uint256 _length = al.length;

        for (uint256 i = 0; i < _length; ++i) {
            // console.log("Start Circle");
            // console.log(al[i]._reserved, al[i]._reserved & 1 == 0);
            if (!_contains(_outData, _buflen, al[i].asn)) {
                // на каждой итерации сохраняем в _outData по индексу _buflen текущий аккаунт
                _outData[_buflen++] = al[i];
                // Рекурсивно вызываем _fetch
                Account memory acc = accounts[al[i].asn];
                bytes32 hash = keccak256(
                    abi.encodePacked(acc.id, origins[acc.originId])
                );
                _buflen = _fetch(_outData, hash, _buflen);
            }
            // console.log("End Circle");
        }
        // console.log(_length);
        return _buflen;
    }

    function _contains(
        AccountLink[] memory arr,
        uint256 len,
        uint64 asn
    ) private pure returns (bool) {
        for (uint256 i = 0; i < len; ++i) {
            if (arr[i].asn == asn) return true;
        }
        return false;
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
    function confirmLink(bytes32 accountHash, uint64 linkNum) public {
        //require(linkId < accounts.length, "The account does not exist");

        // Write the Account Link structure
        accountLinks[accountHash][linkNum].status = 1;
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
