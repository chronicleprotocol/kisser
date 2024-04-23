// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IToll} from "chronicle-std/toll/IToll.sol";

import {Auth} from "chronicle-std/auth/Auth.sol";

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
contract Kisser is Auth {
    constructor(address initialAuthed) Auth(initialAuthed) {}

    /// @notice Kisses address `who` on IToll instance `where`.
    ///
    /// @dev Reverts if:
    ///      - Kisser not auth'ed on IToll instance `where`
    ///
    /// @dev Only callable by auth'ed addresses.
    ///
    /// @param where The IToll instance to kiss on.
    /// @param who The address to kiss on the IToll instance.
    function kiss(address where, address who) external auth {
        IToll(where).kiss(who);
    }

    /// @notice Kisses addresses `whos` on IToll instance `where`.
    ///
    /// @dev Reverts if:
    ///      - Kisser not auth'ed on IToll instance `where`
    ///
    /// @dev Only callable by auth'ed addresses.
    ///
    /// @param where The IToll instance to kiss on.
    /// @param whos The addresses to kiss on the IToll instance.
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
