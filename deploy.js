const HDWalletProvider = require('truffle-hdwallet-provider')
const Web3 = require('web3')
const {interface,bytecode} = require('./compile')

const provider = new HDWalletProvider(
    'deal leave doctor adjust bone small wood material sense argue rely fall',
    'https://rinkeby.infura.io/v3/463303dee41f43e799c8c449813a1bf5'
)

const web3 = new Web3(provider);

const deploy = async () =>{
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from account',accounts[0])

    const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({data:bytecode})
    .send({gas:'1000000',from:accounts[0]})

    console.log('Contract is deployed to',result.options.address)
}
deploy();