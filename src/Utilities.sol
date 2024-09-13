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
}
