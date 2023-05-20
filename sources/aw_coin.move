// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

module aw_coin::awt {
    use std::option::some;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url;

    /// The total supply of Sui denominated in Mist (10 Billion * 10^9)
    const TOTAL_SUPPLY_MIST: u64 = 10_000_000_000_000_000_000;

    struct AWT has drop {}

    fun init(witness: AWT, ctx: &mut TxContext) {
        let url = some(url::new_unsafe_from_bytes(b"https://www.luckystar.homes/_next/static/media/logo.0fcacc03.svg"));
        let (treasury_cap, metadata) = coin::create_currency<AWT>(witness, 9, b"AWT", b"Awt", b"", url, ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    public entry fun transfer(c: coin::Coin<AWT>, recipient: address) {
        transfer::public_transfer(c, recipient)
    }

    /// Manager can mint new coins
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<AWT>,amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

}