pragma solidity >=0.6.0 <0.9.0;

interface ICrossChain {
    function setVaults(address _vault) external;

    function deposit() external;

    function withdraw(uint256 _amount) external;

    function startEpoch(address _reci) external;

    function endEpoch() external;

    function balanceOf() external view returns (uint256);

    function redeemEth() external;

    function vault() external view returns (address);

    function chef() external view returns (address);

    function stake() external view returns (address);

    function balanceOfWant() external view returns (uint256);

    function balanceOfPool() external view returns (uint256);

    function harvest() external;

    function managerHarvest() external;

    function retireStrat() external;

    function panic() external;

    function pause() external;

    function unpause() external;

    function paused() external view returns (bool);

    function router() external view returns (address);

    function poolId() external view returns (uint256);

    function owner() external view returns (address);

    function manager() external view returns (address);

    function epochRunning() external view returns (bool);
}
