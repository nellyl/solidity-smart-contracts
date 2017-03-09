LAM Nelly HAMIDI Melinda ZHANG Yan

ragma solidity ^0.4.0; 

contract Voting { 
Voter[] voters; 
struct Voter { 
bool voted; 
address addresse; 
uint vote; 
} 
Proposal[] proposals; 
struct Proposal { 
uint voteCount; 
bytes32 nom; 
} 
address public chairperson;

// Allow voters to vote, take in argument the proposal
function Vote(uint proposal)
{
    for(uint i = 0; i< voters.length ; i++)
    {
        if(msg.sender == voters[i].addresse)
        {
            if(voters[i].voted) throw;
            voters[i].voted = true;
            proposals[proposal].voteCount += 1;
            voters[i].vote = proposal;
        }
    }
}

// Allow to add a new voter to the voters tab this operation can be only
// perform by the chairman, the voter mustn't being already present in the tab
// Takes in parameter the address of the voter
function Add(address newVoter) {
    bool present = false;
    if (msg.sender != chairperson)
    {
        throw;
    }
    for(uint i = 0; i< voters.length ; i++)
    {
        if(newVoter == voters[i].addresse)
        {
            present = true ;
        }
    }
    if(!present)
    {
        voters.push(Voter({voted : false, addresse : newVoter, vote : 0 }));
    }

}

// Allow to add a new proposal to proposals tab this operation can be only
// perform by the chairman
// Takes in parameter the name of the proposal
function New(bytes32 newProposal) {
    bool present = false;
    if (msg.sender != chairperson)
    {
        throw;
    }
    for(uint i = 0; i< proposals.length ; i++)
    {
        if(newProposal == proposals[i].nom) throw;
        proposals.push( Proposal({nom : newProposal , voteCount : 0 }));
    }
}

function Win() constant returns (uint winningProposal)
{
    uint winningVoteCount = 0;
    for (uint i = 0; i < proposals.length; i++) {
        if (proposals[i].voteCount > winningVoteCount) {
            winningVoteCount = proposals[i].voteCount;
            winningProposal = i;
        }
    }
}

function Winner() constant
        returns (bytes32 winnerName)
{
    winnerName = proposals[winningProposal()].nom;
}
}