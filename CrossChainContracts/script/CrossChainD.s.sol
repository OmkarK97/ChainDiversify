pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/vaults/EarthAutoCompoundingVaultPublic.sol";
import "../src/strategies/irs/CrossChain.sol";
import "../src/strategies/irs/interfaces/ICrossChain.sol";

contract CrossChainScript is Script {
    address public _token = 0x8734110e5e1dcF439c7F549db740E546fea82d66; // wbit mantle
    address public _riveraVault = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE;
    address public _worm = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE;
    address public _tbr = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE;
    address public _wh = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE;
    address public _stargate = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE;
    uint16 public _dstChain = 1;
    address public _relayer = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE;

    uint256 stratUpdateDelay = 172800;
    uint256 vaultTvlCap = 10000e18;

    function run() public {
        uint privateKey = vm.envUint("PRIVATE_KEY");
        address acc = vm.addr(privateKey);
        console.log("Account", acc);

        vm.startBroadcast(privateKey);

        EarthAutoCompoundingVaultPublic vault = new EarthAutoCompoundingVaultPublic(
                _token,
                "Fuji-Poly-USDC-Vault",
                "FujiPolyUSDC",
                stratUpdateDelay,
                vaultTvlCap
            );
        console2.logAddress(address(vault));

        CrossChain cc = new CrossChain(
            _token,
            _riveraVault,
            _worm,
            _tbr,
            _wh,
            _stargate,
            _dstChain,
            _relayer
        );

        vault.init(ICrossChain(address(cc)));
        cc.setVaults(address(vault));
        console2.logAddress(address(cc));

        vm.stopBroadcast();
    }
}
