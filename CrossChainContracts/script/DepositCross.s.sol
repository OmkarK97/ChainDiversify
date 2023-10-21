pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/strategies/irs/interfaces/ICrossChain.sol";
import "../src/vaults/EarthAutoCompoundingVaultPublic.sol";

import "@openzeppelin/token/ERC20/IERC20.sol";

contract DepositCross is Script {
    address _vaultParent = 0x7E470Ec3D2D87930dEDCDF5A7f77d6F743BD5496; //Parent Valut
    address _parentStrat = 0x74EA4F0C16a2D1f1C14ad80A84bbc7c9E4f44464; //Parent Strat
    address _lp0Token = 0x8734110e5e1dcF439c7F549db740E546fea82d66; //fuji usdc

    function run() public {
        uint privateKeyOwn = vm.envUint("OWNER_KEY");
        uint userPrivateKey = vm.envUint("PRIVATE_KEY");
        address user = vm.addr(userPrivateKey);
        address owner = vm.addr(privateKeyOwn);
        console2.log("user", user);

        uint256 depositAmountParent = 100000000000000000;

        vm.startBroadcast(userPrivateKey);

        IERC20(_lp0Token).approve(_vaultParent, depositAmountParent);

        EarthAutoCompoundingVaultPublic(_vaultParent).deposit(
            depositAmountParent,
            user
        );

        vm.stopBroadcast();
    }
}
// //forge script script/Deposit.s.sol:Deposit --rpc-url https://rpc.testnet.mantle.xyz --broadcast -vvv --legacy --slow
