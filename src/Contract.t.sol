// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
import { Contract } from "./Contract.sol";

contract MyTest is Test {
    Contract myContract = new Contract();

    function testDeployContractWithAnotherVersion() public {
        bytes memory bytecode = vm.getCode("Contract6.sol:Contract6");
        address anotherAddress;
        assembly {
            anotherAddress := create(0, add(bytecode, 0x20), mload(bytecode))
        }

        // Different compiler versions will produce different bytecodes
        assertFalse(keccak256(address(myContract).code) == keccak256(anotherAddress.code)); // [PASS]
    }
}
