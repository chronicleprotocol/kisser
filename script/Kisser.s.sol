// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {Script} from "forge-std/Script.sol";
import {console2 as console} from "forge-std/Test.sol";

import {IAuth} from "chronicle-std/auth/IAuth.sol";

import {IGreenhouse} from "greenhouse/IGreenhouse.sol";

import {Kisser_COUNTER as Kisser} from "src/Kisser.sol";
// TODO        ^^^^^^^ Adjust name of Kisser instance.

/**
 * @notice Kisser Management Script
 */
contract KisserScript is Script {
    /// @dev Deploys a new Kisser instance via Greenhouse instance `greenhouse`
    ///      and salt `salt` with `initialAuthed` being the address initially
    ///      auth'ed.
    function deploy(address greenhouse, bytes32 salt, address initialAuthed)
        public
    {
        // Create creation code with constructor arguments.
        bytes memory creationCode = abi.encodePacked(
            type(Kisser).creationCode, abi.encode(initialAuthed)
        );

        // Ensure salt not yet used.
        address deployed = IGreenhouse(greenhouse).addressOf(salt);
        require(deployed.code.length == 0, "Salt already used");

        // Plant creation code via greenhouse.
        vm.startBroadcast();
        IGreenhouse(greenhouse).plant(salt, creationCode);
        vm.stopBroadcast();

        console.log("Deployed at", deployed);
    }

    // -- IAuth Functions --

    /// @dev Grants auth to address `who`.
    function rely(address self, address who) public {
        vm.startBroadcast();
        IAuth(self).rely(who);
        vm.stopBroadcast();

        console.log("Relied", who);
    }

    /// @dev Renounces auth from address `who`.
    function deny(address self, address who) public {
        vm.startBroadcast();
        IAuth(self).deny(who);
        vm.stopBroadcast();

        console.log("Denied", who);
    }
}
