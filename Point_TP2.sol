pragma solidity ^0.4.0; 

// Loyalty points system using ethereum blockchain

contract Point{

    Client[] clients;
    struct Client{
        address address_c;
        uint balance;
    }
	
	Manager[] managers;
	struct Manager {
        address address_m;
    }
    
    address public chairperson;

	// Initialisation of the contract chairperson 
    function Points() {
        chairperson = msg.sender;
    }
	
	modifier theChairperson(){
        if(msg.sender != chairperson) throw; 
        _;
    }
    
    modifier theManager(){
        for(uint i = 0; i < managers.length ; i++ ){
            if(managers[i].address_m == msg.sender)
            _;
        } throw;
    }
	
	// Get the balance of the client
	function getBalance(uint _aIndex) theManager() constant returns(uint) {
        return clients[_aIndex].balance;
    }
	
	// The chairperson can add a new manager
    function AddManager(address new_manager) theChairperson() {
        bool existed = false;
        for(uint i = 0; i< managers.length ; i++){
            if(new_manager == managers[i].address_m){
                existed = true;
            }
        }
        if(existed)throw;
		else{
            managers.push(Manager({address_m : new_manager}));
        }
    }
	
    // The manager can add a new client 
    function AddClient(address new_client)  theManager(){
        bool existed = false;
        for(uint i = 0; i< clients.length ; i++){
            if(new_client == clients[i].address_c){
                existed = true;
            }
        }
        if(existed)throw;
        else{
            clients.push(Client({address_c : new_client, balance : 0}));
        }
    }
	
	// The manager can attribute points to a client account
    function Attribute(address new_client, uint new_points) theManager() {
        for(uint i  = 0 ; i < clients.length; i++){
            if(clients[i].address_c == new_client){
                clients[i].balance += new_points;
            }
            else{ throw; } 
        }
    } 
    
    // Manager can use points for payments 
    // Only manager can perform the operation 
    function Use(address new_client, uint new_points) theManager() {
        for(uint i  = 0 ; i < clients.length; i++){
            if(clients[i].address_c == new_client){
                if( getBalance(i) > new_points){
                    clients[i].balance = clients[i].balance - new_points;
                }
				else{ throw; }   
            }
        }
    }

	// Get the new balance of the account client
	function Balance(address new_client) theManager() constant returns(uint){
        for(uint i  = 0 ; i < clients.length; i++){
            if(clients[i].address_c == new_client){
				return getBalance(i);
            }
        }
        throw;
    }
}