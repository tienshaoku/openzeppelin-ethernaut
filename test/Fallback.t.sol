// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback public fallbackTest;
    address public alice = makeAddr("alice");

    function setUp() public {
        fallbackTest = new Fallback();

        vm.deal(alice, 1 ether);
    }

    function test() public {
        assertEq(fallbackTest.owner(), address(this));

        vm.startPrank(alice);
        fallbackTest.contribute{value: 0.0001 ether}();
        address(fallbackTest).call{value: .5 ether}("");

        assertEq(fallbackTest.owner(), alice);
        fallbackTest.withdraw();
    }
}
