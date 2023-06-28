// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 < 0.9.0;
 
interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}
 contract Block is IERC20 {
string public name ="Bitcoin";
string public symbol="BTC";
uint public decimal=0;
uint public totalSupply;
address public founder;
mapping (address=>uint) public balances;
mapping (address=>mapping (address=>uint)) public allowed;
constructor(){
totalSupply=1000;
founder=msg.sender;
balances[founder]=totalSupply;
}
function balanceOf(address tokenOwner) external view returns (uint){
    return balances[tokenOwner];
}
    function transfer(address recipient, uint tokens) external returns (bool){
        require(balances[msg.sender]>=tokens,"Not enough tokens");
        balances[msg.sender]-=tokens;
        balances[recipient]+=tokens;
            emit Transfer(msg.sender,recipient, tokens);

        return true;
    }
    function allowance(address owner, address spender) external view returns (uint){
        return allowed[owner][spender];
    }
    function approve(address spender, uint tokens) external returns (bool){
        require(balances[msg.sender]>=tokens,"Not enough tokens");
        require(tokens>0,"Zero tokens not allowed");
        allowed[msg.sender][spender]=tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;

    }

function transferFrom(address sender,address recipient,uint tokens) external returns (bool){
require(allowed[sender][recipient]>=tokens,"You're not apporved for this much of tokens");
require(balances[sender]>=tokens,"insufficient tokens");
balances[recipient]+=tokens;
balances[sender]-=tokens;
return true;

    }
}
