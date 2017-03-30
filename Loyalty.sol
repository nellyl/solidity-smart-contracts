LAM Nelly HAMIDI Melinda ZHANG Yan

pragma solidity ^0.4.0; 

contract Loyalty{

    Client[] clients;
    struct Client{
        address id;
        uint point;
        address sponsor;
    }
    
	Product[]products;
    struct Product{
        bytes32 name;
        uint reward;
    }
    
    address public chairperson;

    // Allow to add a new account
    function Add(address sponsorC){
        for(uint i = 0; i < clients.length ; i++)
        {
            if(msg.sender != clients[i].id){ 
                clients.push( Client({
				    point: 0,
                    id : msg.sender, 
                    sponsor : sponsorC
                }));
            }
            else{
                throw;
            }
        }
    }
	
	// Allow to attribute product's points to a client
    function Attribute(bytes32 productName){
        for(uint i = 0;i<clients.length;i++){
            for(uint j = 0;j<products.length;j++){
                if(clients[i].id == msg.sender && products[j].name == productName){
                    clients[i].point += products[j].reward;
                }
            }
        }
    }
    
    // Allow to sponsor a new client
    function Sponsoring(address new) returns(bool){
        uint s_id;
        for(uint i = 0;i<clients.length;i++){
            if(clients[i].id==msg.sender){
                s_id = i;
            }
            
            if(clients[i].id==new && clients[i].sponsor == address(0)){
                clients[i].sponsor = msg.sender;
                clients[i].point +=50;
                clients[s_id].point += 50;
                return true;
            }
            else{
                return false;
            }
        }
    }
}