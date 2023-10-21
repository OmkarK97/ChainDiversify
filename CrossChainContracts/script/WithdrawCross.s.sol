pragma solidity ^0.8.4;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "../src/vaults/EarthAutoCompoundingVaultPublic.sol";
import "../src/strategies/irs/CrossChain.sol";
import "../src/strategies/irs/interfaces/ICrossChain.sol";

contract WithdrawCross is Script {
    address _vaultParent = 0x9124F6dC385CB657b518e2B7dEF1E40918925E85;
    address _vaultAsset0 = 0x363a72B0C23b0C73130f082a57aA4b17AdB48645;
    address _vaultAsset1 = 0x36F0654E3083a488D419ea90a65CA2511Cf75597;

    function run() public {
        uint privateKeyOwn = vm.envUint("OWNER_KEY");
        uint userPrivateKey = vm.envUint("PRIVATE_KEY");
        address user = vm.addr(userPrivateKey);
        address owner = vm.addr(privateKeyOwn);
        console2.log("user", user);

        uint256 withdrawAmountParent = EarthAutoCompoundingVaultPublic(
            _vaultParent
        ).maxWithdraw(user);

        console2.log(withdrawAmountParent);

        vm.startBroadcast(userPrivateKey);
        EarthAutoCompoundingVaultPublic(_vaultParent).withdraw(
            withdrawAmountParent,
            user,
            user
        );

        vm.stopBroadcast();
    }
}
