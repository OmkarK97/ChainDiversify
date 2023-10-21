pragma solidity ^0.8.0;

import "./interfaces/IWormholeReceiver.sol";
import "./interfaces/IWormholeRelayer.sol";
import "./interfaces/IRivera.sol";
import "./interfaces/IStargateRouter.sol";

contract reciHello is IWormholeReceiver {
    address public wormholeRelayer;
    uint16 public targetChain;
    uint256 public GAS_LIMIT = 50000;

    function receiveWormholeMessages(
        bytes memory payload,
        bytes[] memory additionalVaas,
        bytes32 sourceAddress,
        uint16 sourceChain,
        bytes32 deliveryHash
    ) public payable override {
        (string memory direction, address token) = abi.decode(
            payload,
            (string, address)
        );

        if (direction == "Start") {
            deployLiqui();
        } else {
            withDrawLiqui();
        }
    }

    function deployLiqui() internal {}
}
