// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Executables } from "src/Executables.sol";
import { console } from "forge-std/console.sol";
import { VmSafe } from "forge-std/Vm.sol";

library Utils {
    function parseCsv(VmSafe vm, string memory csvFile, string memory types)
        internal
        returns (bytes memory)
    {
        string memory root = vm.projectRoot();
        string[] memory cmd = new string[](3);
        cmd[0] = Executables.bash;
        cmd[1] = "-c";
        cmd[2] = string.concat(root, "/lib/solidity-helpers/scripts/packCsv.sh ", types, " ", csvFile);
        return vm.ffi(cmd);
    }

    /*
    function splitString(string memory source, string memory separator) internal pure returns (string[] memory) {
        bytes memory sourceBytes = bytes(source);
        bytes memory separatorBytes = bytes(separator);

        uint256 count = 1;
        for (uint256 i; i < sourceBytes.length; i++) {
            if (sourceBytes[i] == separatorBytes[0]) {
                count++;
            }
        }

        string[] memory splitArray = new string[](count);
        uint256 index = 0;
        uint256 lastIndex = 0;
        for (uint256 i = 0; i <= sourceBytes.length; i++) {
            if (i == sourceBytes.length || sourceBytes[i] == separatorBytes[0]) {
                bytes memory word = new bytes(i - lastIndex);
                for (uint256 j = lastIndex; j < i; j++) {
                    word[j - lastIndex] = sourceBytes[j];
                }
                splitArray[index] = string(word);
                index++;
                lastIndex = i + 1; // skip the separator
            }
        }
        return splitArray;
    }

    function parseCSV(string memory csvString)
        internal
        pure
        returns (string[][] memory parsedCsv)
    {
        string[] memory rows = splitString(csvString, "\n");
        uint256 rowsLength = rows.length;
        if (bytes(rows[rowsLength - 1]).length == 0) {
            rowsLength -= 1;
        }
        parsedCsv = new string[][](rowsLength);
        for (uint256 i; i < rowsLength; i++) {
            string[] memory columns = splitString(rows[i], ",");
            parsedCsv[i] = columns;
        }
    }

    function parseMerkleRootsCSV(
        string memory csvString,
        uint256 batchSize
    )
        internal
        pure
        returns (bytes32[][] memory merkleRootsBatches)
    {
        string[] memory rows = splitString(csvString, "\n");
        uint256 rowsLength = rows.length;
        if (bytes(rows[rowsLength - 1]).length == 0) {
            rowsLength -= 1;
        }
        uint256 batches = rowsLength / batchSize;
        if (rowsLength % batchSize != 0) {
            batches += 1;
        }

        merkleRootsBatches = new bytes32[][](batches);
        for (uint256 i; i < batches; i++) {
            uint256 size = batchSize;
            if (i == batches - 1 && rowsLength % batchSize != 0) {
                size = rowsLength % batchSize;
            }
            merkleRootsBatches[i] = new bytes32[](size);
            for (uint256 j; j < batchSize; j++) {
                uint256 rowIndex = i * batchSize + j;
                if (rowIndex == rowsLength) {
                    break;
                }
                merkleRootsBatches[i][j] = hexStrToBytes32(rows[rowIndex]);
            }
        }
    }

    function parseUint(string memory s) internal pure returns (uint256) {
        return parseUint(bytes(s));
    }

    function parseUint(bytes memory b) internal pure returns (uint256) {
        uint256 result;
        if (uint8(b[0]) == 48) {
            revert("Invalid int")
        }
        for (uint256 i; i < b.length; i++) {
            if (uint8(b[i]) >= 48 && uint8(b[i]) <= 57) {
                result = result * 10 + (uint8(b[i]) - 48);
            } else {
                revert("Invalid int");
            }
        }
        return result;
    }

    function parseInt(string memory s) internal pure returns (int256) {
        bytes memory b = bytes(s);
        if (uint8(b[0]) == 45) {
            return -1 * int256(parseUint(b[1:]));
        } else {
            return int256(parseUint(b));
        }
    }

    function hexStrToAddress(string memory hexStr) internal pure returns (address) {
        bytes memory hexBytes = bytes(hexStr);
        require(hexBytes.length == 42, "Hex string should have 42 characters including '0x'.");

        uint160 addr = 0;
        for (uint256 i = 2; i < 42; i++) {
            uint160 byteValue = uint160(hexCharToByte(hexBytes[i]));
            addr = addr * 16 + byteValue;
        }

        return address(addr);
    }

    function hexStrToBytes32(string memory hexStr) internal pure returns (bytes32) {
        bytes memory hexBytes = bytes(hexStr);
        require(hexBytes.length == 66, "Hex string has invalid length");

        uint256 word = 0;
        for (uint i = 2; i < 66; i++) {
            uint160 byteValue = uint160(hexCharToByte(hexBytes[i]));
            word = word * 16 + byteValue;
        }
        return bytes32(word);
    }

    function hexCharToByte(bytes1 hexChar) internal pure returns (uint8) {
        uint8 byteValue = uint8(hexChar);
        if (byteValue >= 48 && byteValue <= 57) {
            return byteValue - 48; // 0-9
        } else if (byteValue >= 65 && byteValue <= 70) {
            return byteValue - 55; // A-F
        } else if (byteValue >= 97 && byteValue <= 102) {
            return byteValue - 87; // a-f
        } else {
            revert("Invalid hex character.");
        }
    }
    */
}
