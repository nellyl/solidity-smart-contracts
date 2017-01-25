# solidity-smart-contracts
LAM Nelly 
HAMIDI Melinda
ZHANG Yan

pragma solidity ^0.4.0;
contract Voting {
    
    // A single voter
    Voter[] public voters;
    struct Voter {
        bool voted;
        uint8 vote;
        address delegate;
    }

    // A type of proposal
    Proposal[] public proposals;
    struct Proposal {
        uint voteCount;
        bytes32 name;
    }

    // A chairperson
    address public chairperson;


    // Function to give the right to vote 
    function RightToVote(uint8 proposal) {
        for(uint i = 0; i< voters.length ; i++) {
            if(msg.sender == voters[i].delegate) {
                if(voters[i].voted) {
                    throw;
                }
                voters[i].voted = true;
                proposals[proposal].voteCount += 1;
                voters[i].vote = proposal;
            }
        }
    }
    
    // Function to add a voter
    function AddingVoter(address newVoter) {
        bool presence = false;
        if (msg.sender != chairperson) {
            throw;
        }
        for(uint i = 0; i< voters.length ; i++) {
            if(newVoter == voters[i].delegate) {
                presence = true ;
            }
        }
        if(!presence) {
            voters.push(Voter({
                voted : false, delegate : newVoter, vote : 0 
            }));
        }
    }

    // Function to add a proposal
    function AddingProposal(bytes32 newProposal) {
        bool present = false;
        if (msg.sender != chairperson) {
            throw;
        }
        for(uint i = 0; i< proposals.length ; i++) {
            if(newProposal == proposals[i].name){
                throw;
            }
            proposals.push(Proposal({
                name : newProposal , voteCount : 0 
                
            }));
        }
    }

    // Function to find the winning proposal
    function Winning() constant returns (uint winning) {
        uint winningCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningCount) {
                winningCount = proposals[i].voteCount;
                winning = i;
            }
        }
    }
}
