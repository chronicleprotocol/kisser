// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IToll} from "chronicle-std/toll/IToll.sol";

import {Auth} from "chronicle-std/auth/Auth.sol";

import {IKisser} from "./IKisser.sol";

/**
 * @title Kisser
 *
 * @notice A simple contract to kiss addresses on IToll instances
 *
 * @dev This contract can be auth'ed on Scribe(Optimistic) instances to enable
 *      bypassing DAO procedures for simple kisses.
 *
 *      The contract as is simple as possible and does not allow any
 *      programmability.
 *
 * @author Chronicle Labs, Inc.
 * @custom:security-contact security@chroniclelabs.org
 */
contract Kisser is IKisser, Auth {
    constructor(address initialAuthed) Auth(initialAuthed) {}

    /// @inheritdoc IKisser
    function kiss(address where, address who) external auth {
        IToll(where).kiss(who);
    }

    /// @inheritdoc IKisser
    function kiss(address where, address[] memory whos) external auth {
        for (uint i; i < whos.length; i++) {
            IToll(where).kiss(whos[i]);
        }
    }
}

/**
 * @dev Contract overwrite to deploy contract instances with specific naming.
 *
 *      For more info, see docs/Deployment.md.
 */
contract Kisser_COUNTER is Kisser {
    constructor(address initialAuthed) Kisser(initialAuthed) {}
}
