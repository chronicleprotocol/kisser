// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {IToll} from "chronicle-std/toll/IToll.sol";

import {Auth} from "chronicle-std/auth/Auth.sol";

interface IKisser {
    /// @notice Kisses address `who` on IToll instance `where`.
    ///
    /// @dev Reverts if:
    ///      - Kisser not auth'ed on IToll instance `where`
    ///
    /// @dev Only callable by auth'ed addresses.
    ///
    /// @param where The IToll instance to kiss on.
    /// @param who The address to kiss on the IToll instance.
    function kiss(address where, address who) external;

    /// @notice Kisses addresses `whos` on IToll instance `where`.
    ///
    /// @dev Reverts if:
    ///      - Kisser not auth'ed on IToll instance `where`
    ///
    /// @dev Only callable by auth'ed addresses.
    ///
    /// @param where The IToll instance to kiss on.
    /// @param whos The addresses to kiss on the IToll instance.
    function kiss(address where, address[] memory whos) external;
}
