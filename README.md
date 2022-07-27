# Using `forge` with multiple `solc` versions

This is a proof of concept to enable multi-version Solidity projects with [Foundry](https://book.getfoundry.sh/).

This example uses Solidity `0.6.12` and `0.8.14`, but in theory it could work for any two or more versions.

## Rationale

- Have separate `src` directories for both versions.
- Have separate `lib` directories for both versions, but allow the non-default versions to pull compatible dependencies from the default one.
- Test files and Solidity scripts go into the `src` directories and not in separate `test` and `script` ones.

## Usage

Compile the non-default versions first:
```
FOUNDRY_PROFILE=0_6_x forge build
```

Compile the default version last:
```
forge build
```

To reference contracts from compiled with versions, use the [`getCode()` cheat code](https://book.getfoundry.sh/cheatcodes/get-code):

```solidity
pragma solidity ^0.8.14;

import "forge-std/Test.sol";

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
```
