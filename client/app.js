const enableButton = document.getElementById('enable-button');
const ethAmountButton = document.getElementById('eth-amount-button');
const poolBalance = document.getElementById('pool');
//const lotteryAddress;
//const lotteryABI;

window.addEventListener('load', async (event) => {
    //const balance = await readLotteryPoolBalance();
    //poolBalance.innerHTML = balance.toFixed(2);
  });

enableButton.onclick = async () => {
    if(typeof window.ethereum !== 'undefined'){
        await ethereum.request({ method: 'eth_requestAccounts' });
    }
    else{
        alert("Metamask is not available...Please install it to continue");
    }
}

ethAmountButton.onclick = async () => {
    const inputValue = document.getElementById('eth-amount').value;
    var web3 = new Web3();
    web3.setProvider(window.ethereum);
    var accounts = await web3.eth.getAccounts();
    const weiBalance = await web3.eth.getBalance(accounts[0]);
    const ethBalance = web3.utils.fromWei(weiBalance, 'ether');

    if(inputValue <= ethBalance){
        //Create contract insntance and send eth amount.
    }
    else{
        alert("The amount you are trying to send is more than your wallet balance!");
    }  
}

async function readLotteryPoolBalance(){
    //Create contract insntance and read balance.
}