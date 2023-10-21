// // SPDX-License-Identifier: SEE LICENSE IN LICENSE
// pragma solidity ^0.8.0;

// import "forge-std/Script.sol";
// import "forge-std/console2.sol";
// import "../src/strategies/irs/EarthLpStaking.sol";
// import "../src/strategies/irs/CommonStrat.sol";
// import "../src/strategies/common/interfaces/IStrategy.sol";
// import "../src/vaults/EarthAutoCompoundingVaultPublic.sol";

// contract EarthLpStakingScript is Script {
//     address _stake = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE; //Rivera Lp-FSX-WMNT
//     uint256 _poolId = 1;
//     address _chef = 0x9316938Eaa09E71CBB1Bf713212A42beCBa2998F; //FusionX MasterChefV3
//     address _router = 0x45e6f621c5ED8616cCFB9bBaeBAcF9638aBB0033; // FusionXv2 smart router
//     address _reward = 0xB38E748dbCe79849b8298A1D206C8374EFc16DA7; //Wbit address for now
//     address _lp0Token = 0x8734110e5e1dcF439c7F549db740E546fea82d66; //FusionX WMNT
//     address _lp1Token = 0x6dFB16bc471982f19DB32DEE9b6Fb40Db4503cBF; //FusionX FSX token
//     address _factory = 0x272465431A6b86E3B9E5b9bD33f5D103a3F59eDb; //FusionX v3 factory
//     address riveraVault = 0x52f059A19291775f0BbC91cDca5A6c5dDFBb6ddE; // rivera FSX-WMNT vault

//     address[] _rewardToLp0Route = new address[](2);
//     address[] _rewardToLp1Route = new address[](2);

//     uint256 stratUpdateDelay = 172800;
//     uint256 vaultTvlCap = 10000e18;

//     function setUp() public {
//         _rewardToLp0Route[0] = _reward;
//         _rewardToLp0Route[1] = _lp0Token;
//         _rewardToLp1Route[0] = _reward;
//         _rewardToLp1Route[1] = _lp1Token;
//     }

//     function run() public {
//         uint privateKey = vm.envUint("PRIVATE_KEY");
//         address acc = vm.addr(privateKey);
//         console.log("Account", acc);

//         vm.startBroadcast(privateKey);
//         //deploying the AutoCompounding vault
//         EarthAutoCompoundingVaultPublic vault = new EarthAutoCompoundingVaultPublic(
//                 _stake,
//                 "Earth-FSX-WMNT-Vault",
//                 "Earth-FSX-WMNT-Vault",
//                 stratUpdateDelay,
//                 vaultTvlCap
//             );
//         CommonAddresses memory _commonAddresses = CommonAddresses(
//             address(vault),
//             _router
//         );
//         EarthLpStakingParams memory earthLpStakingParams = EarthLpStakingParams(
//             _stake,
//             _poolId,
//             _chef,
//             _rewardToLp0Route,
//             _rewardToLp1Route,
//             _lp0Token,
//             _factory
//         );

//         //Deploying the parantStrategy

//         EarthLpStaking parentStrategy = new EarthLpStaking(
//             earthLpStakingParams,
//             _commonAddresses,
//             riveraVault
//         );
//         vault.init(IStrategy(address(parentStrategy)));
//         console2.logAddress(address(vault.strategy()));
//         console.log("ParentVault-FSM-WMNT");
//         console2.logAddress(address(vault));
//         console.log("ParentStrategy-FSX-WMNT");
//         console2.logAddress(address(parentStrategy));
//         vm.stopBroadcast();
//     }
// }

// /*    Account 0x69605b7A74D967a3DA33A20c1b94031BC6cAF27c
//   0xde792D4165D022d3E40bf5E51879e1664F344B6D
//   ParentVault
//   0xacFaf415595B2109B06D864B01fB282E0cE959A4
//   ParentStrategy
//   0xde792D4165D022d3E40bf5E51879e1664F344B6D
// */

// // forge script script/EarthLpStaking.s.sol:EarthLpStakingScript --rpc-url https://rpc.testnet.mantle.xyz --broadcast -vvv --legacy --slow

// /*
// Account 0x69605b7A74D967a3DA33A20c1b94031BC6cAF27c
//   0xA327808A9B765DeeB9A30DB7F1e3fA5Da9d2C64c
//   ParentVault-FSM-WMNT
//   0x9124F6dC385CB657b518e2B7dEF1E40918925E85
//   ParentStrategy-FSX-WMNT
//   0xA327808A9B765DeeB9A30DB7F1e3fA5Da9d2C64c
// */
