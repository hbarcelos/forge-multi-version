// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import "forge-std/Test.sol";
import { Contract } from "./Contract.sol";

contract MyTest is Test {
    Contract myContract = new Contract();

    function testDeployContractWithAnotherVersion() public {
        address anotherAddress = deployCode("Contract6.sol:Contract6");

        // Different compiler versions will produce different bytecodes
        assertTrue(keccak256(address(myContract).code) != keccak256(anotherAddress.code)); // [PASS]
    }
}
