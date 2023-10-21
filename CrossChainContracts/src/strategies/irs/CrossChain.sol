// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/token/ERC20/IERC20.sol";
import "@openzeppelin/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/access/Ownable.sol";
import "@openzeppelin/security/Pausable.sol";
import "@openzeppelin/security/ReentrancyGuard.sol";
import "../utils/StringUtils.sol";
import "./interfaces/IRivera.sol";
import "./interfaces/IStargateRouter.sol";
import "./interfaces/IWormholeRelayer.sol";

contract CrossChain is ReentrancyGuard {
    using SafeERC20 for IERC20;

    bool public epochRunning = false;

    address public token;
    address public vault;
    address public nOwner;
    address public riveraVault;
    address public stargate;
    address public wormholeRelayer;
    uint256 public balBS;
    uint16 dstChain;
    uint256 GAS_LIMIT = 250000;

    modifier onlyVault() {
        require(msg.sender == vault);
        _;
    }

    modifier dOwner() {
        require(msg.sender == nOwner);
        _;
    }

    constructor(
        address _token,
        address _riveraVault,
        address _worm,
        address _tbr,
        address _wh,
        address _stargate,
        uint16 _dstChain,
        address _wormholeRelayer
    ) {
        nOwner = msg.sender;
        token = _token;
        riveraVault = _riveraVault;
        stargate = _stargate;
        dstChain = _dstChain;
        wormholeRelayer = _wormholeRelayer;
    }

    function setVaults(address _vault) public dOwner {
        vault = _vault;
    }

    function deposit() public onlyVault {
        if (epochRunning == true) revert();
    }

    function withdraw(uint256 _amount) external onlyVault nonReentrant {
        if (epochRunning == true) revert();

        uint256 stakeBal = IERC20(token).balanceOf(address(this));

        if (stakeBal < _amount) {
            stakeBal = IERC20(token).balanceOf(address(this));
        }

        if (stakeBal > _amount) {
            stakeBal = _amount;
        }

        IERC20(token).safeTransfer(vault, stakeBal);
    }

    function startEpoch(address _reci, uint16 targetChain) public dOwner {
        if (epochRunning == true) revert();

        balBS = IERC20(token).balanceOf(address(this));

        uint256 balH = balBS / 2;
        uint256 balT = balH;

        IERC20(token).approve(address(riveraVault), balH);

        IRivera(riveraVault).deposit(balH, address(this));

        IStargateRouter(stargate).swap{value: address(this).balance}(
            dstChain,
            1,
            1,
            payable(address(this)),
            balT,
            0,
            IStargateRouter.lzTxObj(0, 0, "0x"),
            abi.encodePacked(_reci),
            bytes("")
        );

        (uint256 cost, ) = IWormholeRelayer(wormholeRelayer)
            .quoteEVMDeliveryPrice(targetChain, 0, GAS_LIMIT);

        string memory direction = "Start";

        bytes memory payload = abi.encode(direction, address(token));
        IWormholeRelayer(wormholeRelayer).sendPayloadToEvm{value: cost}(
            targetChain,
            targetAddress,
            payload,
            0,
            GAS_LIMIT
        );

        epochRunning = true;
    }

    function endEpoch() public dOwner {
        if (epochRunning == false) revert();

        uint256 lpBal = IRivera(riveraVault).balanceOf(address(this));

        IRivera(riveraVault).withdraw(lpBal, address(this), address(this));

        //following will be code to get back transfer from wormhole

        uint256 bal = IERC20(token).balanceOf(address(this));
        IERC20(token).transfer(vault, bal);
        epochRunning = false;
    }

    function balanceOf() public view returns (uint256) {
        if (epochRunning) {
            return balBS;
        }
        return IERC20(token).balanceOf(address(this));
    }

    function redeemEth() public {
        (bool sent, ) = nOwner.call{value: address(this).balance}("");
        require(sent, "Transaction failed");
    }
}
