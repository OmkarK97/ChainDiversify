// pragma solidity ^0.8.4;

// import "forge-std/Script.sol";
// import "forge-std/console2.sol";
// import "@earth/strategies/common/interfaces/IStrategy.sol";
// import "@earth/vaults/EarthAutoCompoundingVaultPublic.sol";
// import "@openzeppelin/token/ERC20/IERC20.sol";

// contract StopEpoch is Script {
//     address _vaultParent = 0x9124F6dC385CB657b518e2B7dEF1E40918925E85;

//     function run() public {
//         // string memory seedPhrase = vm.readFile(".secret");
//         // uint256 ownerPrivateKey = vm.deriveKey(seedPhrase, 0);
//         // address owner = vm.addr(ownerPrivateKey);

//         uint privateKeyOwn = vm.envUint("PRIVATE_KEY");
//         uint userPrivateKey = vm.envUint("PRIVATE_KEY");
//         address user = vm.addr(userPrivateKey);
//         address owner = vm.addr(privateKeyOwn);
//         console2.log("user", user);
//         vm.startBroadcast(privateKeyOwn);
//         ///start epoch
//         IStrategy parentStrategy = EarthAutoCompoundingVaultPublic(_vaultParent)
//             .strategy();
//         parentStrategy.endEpoch();
//         vm.stopBroadcast();
//     }
// }

// // forge script script/StopEpoch.s.sol:StopEpoch --rpc-url https://rpc.testnet.mantle.xyz --broadcast -vvv --legacy --slow
