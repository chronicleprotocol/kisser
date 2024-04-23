// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Test} from "forge-std/Test.sol";
import {console2 as console} from "forge-std/Test.sol";

import {IAuth} from "chronicle-std/auth/IAuth.sol";

import {Auth} from "chronicle-std/auth/Auth.sol";
import {Toll} from "chronicle-std/toll/Toll.sol";

import {Kisser} from "../src/Kisser.sol";

contract KisserTest is Test {
    Kisser public kisser;

    TollInstance toll;

    function setUp() public {
        kisser = new Kisser(address(this));

        // Deploy IToll instances and auth Kisser.
        toll = new TollInstance(address(this));
        toll.rely(address(kisser));
    }

    // -- Test: Deployment --

    function test_Deployment() public view {
        // Address given as constructor argument is auth'ed.
        assertTrue(IAuth(address(kisser)).authed(address(this)));
    }

    // -- Test: Kiss Single --

    function testFuzz_kiss_Single(address who) public {
        kisser.kiss(address(toll), who);

        assertTrue(toll.tolled(who));
    }

    function testFuzz_kiss_Single_FailsIf_KisserNotAuthed(address who) public {
        toll.deny(address(kisser));

        vm.expectRevert(
            abi.encodeWithSelector(
                IAuth.NotAuthorized.selector, address(kisser)
            )
        );
        kisser.kiss(address(toll), who);

        assertFalse(toll.tolled(who));
    }

    // -- Test: Kiss Multiple --

    function testFuzz_kiss_Multiple(address[] memory whos) public {
        kisser.kiss(address(toll), whos);

        for (uint i; i < whos.length; i++) {
            assertTrue(toll.tolled(whos[i]));
        }
    }

    function testFuzz_kiss_Multiple_FailsIf_KisserNotAuthored(
        address[] memory whos
    ) public {
        vm.assume(whos.length != 0);

        toll.deny(address(kisser));

        vm.expectRevert(
            abi.encodeWithSelector(
                IAuth.NotAuthorized.selector, address(kisser)
            )
        );
        kisser.kiss(address(toll), whos);

        for (uint i; i < whos.length; i++) {
            assertFalse(toll.tolled(whos[i]));
        }
    }
}

contract TollInstance is Auth, Toll {
    constructor(address initialAuthed) Auth(initialAuthed) {}

    function toll_auth() internal override(Toll) auth {}
}
